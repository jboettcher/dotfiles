.PHONY: caravan
.DEFAULT_GOAL := all
#---------------------------------------------------------------------------
# Environment
SYS := $(shell uname)
#---------------------------------------------------------------------------
# Platform Makefiles
ifeq ($(SYS),Darwin)
include Makefile.darwin
else
include Makefile.linux
endif
#---------------------------------------------------------------------------
# Caravan image
CARAVAN_IMAGE_NAME=jboettcher/caravan
CARAVAN_IMAGE_TAG=latest
MAKEFILE_PATH := $(abspath $(lastword ${MAKEFILE_LIST}))
MAKEFILE_DIR := $(dir ${MAKEFILE_PATH})
caravan:
	git archive --format=tar HEAD | docker build \
		-t ${CARAVAN_IMAGE_NAME}:${CARAVAN_IMAGE_TAG} \
		-f ./caravan/Dockerfile \
		-
#---------------------------------------------------------------------------
