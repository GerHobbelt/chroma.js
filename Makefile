
COFFEESCRIPT=node_modules/.bin/coffee
UGLIFY=node_modules/.bin/uglifyjs
VOWS=node_modules/.bin/vows

all: chroma.min.js

clean:
	-@rm chroma.js chroma.min.js license.coffee test/test.js

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
	@cat $^ | $(COFFEESCRIPT) -c --stdio > $@

chroma.min.js: chroma.js
	@$(UGLIFY) --comments "@license" chroma.js > $@

test/test.js:						\
		test/*.coffee
	@cat $^ | $(COFFEESCRIPT) -c --stdio > $@

test: test/test.js chroma.js
	$(VOWS) test/test.js
