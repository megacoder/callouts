H	=16
W	=16

DIGITS	=1 2 3 4 5 6 7 8 9 10 11 12 13 14 15

.SUFFIXES: .eps .png .jpg .svg

.svg.png:
	batik -h $H -w $W -d $@ $<

.svg.jpg:
	batik -h $H -w $W -d $@ -q 0.9 -m image/jpg $<

.png.eps:
	/opt/bmeps/bin/bmeps -p3 -g $< $@

SVGFILES=${DIGITS:=.svg}
JPGFILES=${SVGFILES:.svg=.jpg}
PNGFILES=${SVGFILES:.svg=.png}
EPSFILES=${PNGFILES:.png=.eps}

all:	${JPGFILES} ${PNGFILES} ${EPSFILES}

${SVGFILES}: Makefile callout.svg
	DIGIT=$$( echo $@ | sed 's/\..*//' ); sed "s/FIXME/$${DIGIT}/g" callout.svg >$@.tmp && move-if-change $@.tmp $@

clean:
	${RM} ${JPGFILES} ${PNGFILES} ${EPSFILES}

distclean clobber: clean
	${RM} ${SVGFILES}
