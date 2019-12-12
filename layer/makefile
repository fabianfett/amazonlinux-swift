SWIFT_DOCKER_IMAGE=fabianfett/amazonlinux-swift:5.1.2-amazonlinux2

LAYER_FOLDER=swift-lambda-runtime
LAYER_ZIP=$(LAYER_FOLDER).zip
SHARED_LIBS_FOLDER=$(LAYER_FOLDER)/lib

clean_layer:
	rm -r lib || true

create_layer: clean_layer
	mkdir -p lib
	docker run --rm --volume "$(shell pwd)/:/src" --workdir "/src" \
			$(SWIFT_DOCKER_IMAGE) \
			cp -t lib \
					/usr/lib64/libatomic.so.1 \
					/usr/lib/swift/linux/libBlocksRuntime.so \
					/usr/lib/swift/linux/libFoundation.so \
					/usr/lib/swift/linux/libFoundationNetworking.so \
					/usr/lib/swift/linux/libFoundationXML.so \
					/usr/lib/swift/linux/libdispatch.so \
					/usr/lib/swift/linux/libicudataswift.so.61 \
					/usr/lib/swift/linux/libicui18nswift.so.61 \
					/usr/lib/swift/linux/libicuucswift.so.61 \
					/usr/lib/swift/linux/libswiftCore.so \
					/usr/lib/swift/linux/libswiftDispatch.so \
					/usr/lib/swift/linux/libswiftGlibc.so \
					/usr/lib/swift/linux/libswiftSwiftOnoneSupport.so

package_layer: create_layer
	zip -r swift-lambda-layer.zip lib
