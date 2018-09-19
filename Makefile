ROOT := /usr/local/dev/programming/Java/JavaSE9
FILENAME := JavaSE9
AUX := {aux,cps,fns,log,toc}
.PHONY: all
all: tangle weave

.PHONY: tangle weave jrtangle jrweave texi

tangle: jrtangle
weave: jrweave

jrtangle: $(FILENAME).twjr
	jrtangle $(FILENAME).twjr

jrweave: texi

texi: $(FILENAME).texi

$(FILENAME).texi: $(FILENAME).twjr
	jrweave $(FILENAME).twjr > $(FILENAME).texi
.PHONY : makepdf
makepdf : ${FILENAME}.pdf

${FILENAME}.pdf : ${FILENAME}.texi
	pdftexi2dvi ${FILENAME}.texi

.PHONY : pdf
pdf : makepdf
	open ${FILENAME}.pdf


.PHONY: html
html : ${FILENAME}.texi
	makeinfo --html ${FILENAME}.texi

.PHONY: clean
clean:
	rm -f *~
	rm -f $(FILENAME).??

.PHONY : distclean
distclean : clean
	rm -fv ${FILENAME}.${AUX}

.PHONY: worldclean
worldclean :
	for file in ${ROOT}/*; do \
	  [ \
	    $${file} != "${ROOT}/${FILENAME}.twjr" -a \
	    $$file != "${ROOT}/Makefile" -a \
	    $$file != ".git" \
	  ] \
	  && rm -rfv "$${file}" || :; \
	done


.PHONY : makefile
makefile : jrtangle worldclean

