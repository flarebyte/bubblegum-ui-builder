.PHONY: html js

SRC = elm
BUILD = docs
HTML = html

reset:
	rm -rf elm-stuff
	rm -rf docs

build-directory:
	rm -rf docs
	mkdir -p docs

install:
	elm-package install -y
	
build: beautify build-directory html js mint

mint:
	zsh scripts/mint.sh

beautify:
	elm-format elm/ --yes

html:
	cp $(HTML)/index.html $(BUILD)/index.html
	cp $(HTML)/styles.css $(BUILD)/styles.css
js:
	elm-make $(SRC)/app.elm --output $(BUILD)/app.js

start:
	cd docs;http-server -p 7000 -c10 -o
