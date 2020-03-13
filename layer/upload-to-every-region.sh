#!/bin/bash
set -e

SWIFT_TAG="swift-5.1.5-RELEASE"

REGIONS=$(aws ssm get-parameters-by-path \
  --path /aws/service/global-infrastructure/services/lambda/regions \
  --output json | jq -r '[ .Parameters[].Value ] | . - ["ap-east-1", "me-south-1", "cn-north-1", "cn-northwest-1", "us-gov-west-1", "us-gov-east-1"] | .[]')

aws --profile amazonlinux-swift s3 cp ./swift-lambda-layer.zip s3://amazonlinux-swift/layers/${SWIFT_TAG}.zip

while IFS= read -r REGION; do
  echo "-------------------------------------"
  echo "Switching to: $REGION"

  VERSION=$(aws --region $REGION --profile amazonlinux-swift lambda publish-layer-version \
    --layer-name Swift \
    --compatible-runtimes "provided" \
    --license-info "Apache-2.0" \
    --zip-file fileb://$(pwd)/swift-lambda-layer.zip \
    --output json | jq -r '.Version')

  echo "✅ Uploaded version: $VERSION"
  ACCESS=$(aws --region $REGION --profile amazonlinux-swift lambda add-layer-version-permission \
    --layer-name Swift \
    --statement-id "public-access" \
    --action "lambda:GetLayerVersion" \
    --principal "*" \
    --version-number $VERSION \
    --output json)

  echo "✅ Allowed access  : $VERSION"
  
done <<< "$REGIONS"

echo "All uploaded"