
COFFEESCRIPT=node_modules/.bin/coffee
UGLIFY=node_modules/.bin/uglifyjs

all: chroma.min.js

clean:
	-@rm chroma.js chroma.min.js license.coffee

license.coffee: 					\
		LICENSE 					\
		mk_license.sh 				\
		Makefile
	@./mk_license.sh > $@

chroma.js: 							\
		license.coffee 				\
		src/api.coffee 				\
		src/color.coffee 			\
		src/conversions/*.coffee  	\
		src/scale.coffee 			\
		src/limits.coffee 			\
		src/colors/*.coffee 		\
		src/utils.coffee 			\
		src/interpolate.coffee
	@cat $^ | $(COFFEESCRIPT) --stdio > $@

chroma.min.js: chroma.js
	@$(UGLIFY) --comments "@license" chroma.js > $@

test: chroma.js
	@npm test
