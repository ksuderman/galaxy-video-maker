GROUP=ksuderman
NAME=galaxy-video-maker
IMAGE=$(GROUP)/$(NAME)

help:
	@echo "GOALS"
	@echo "   docker - build the image"
	@echo "   tag    - tag the image.  The environment variable VERSION must be set."
	@echo "   push   - push the image. The environment variable VERSION must be set."

check_version:
ifndef VERSION
$(error VERSION has not been set)
endif
	
docker: 
	docker build -t $(IMAGE) .
	
tag: check_version
	@echo "Tagging version $(VERSION)"
	docker tag $(IMAGE) $(IMAGE):$(VERSION)
	
push: check_version
	@echo "Pushing version $(VERSION)"
	docker push $(IMAGE):$(VERSION)
	
	
