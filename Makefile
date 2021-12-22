.PHONY: build
build:
	docker build -t votava/php-ssmtp:5.6.40-apache .

.PHONY: upload
upload:
	docker push votava/php-ssmtp:5.6.40-apache
