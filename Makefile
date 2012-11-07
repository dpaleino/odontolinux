test:
	rm -rf cover/
	@nosetests -v \
		--detailed-errors \
		--with-coverage \
		--cover-package=odonto \
		--cover-erase \
		--cover-tests \
		--cover-html

.PHONY: test
