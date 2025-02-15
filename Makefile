# Makefile for vpk module

define HELPBODY
Available commands:

	make help       - this thing.
	make init       - install python dependancies
	make test       - run tests and coverage
	make pylint     - code analysis
	make build      - pylint + test

endef

export HELPBODY
help:
	@echo "$$HELPBODY"

init:
	pip install pytest==3.2.1 pytest-cov==2.5.1

test:
	rm -f .coverage vpk/*.pyc tests/*.pyc
	PYTHONHASHSEED=0 pytest --cov=vpk tests

pylint:
	pylint -r n -f colorized vpk || true

build: pylint test

clean:
	rm -rf dist vpk.egg-info vpk/*.pyc

dist: clean
	python setup.py sdist
	python setup.py bdist_wheel --universal

upload: dist
	python setup.py register -r pypi
	twine upload -r pypi dist/*
