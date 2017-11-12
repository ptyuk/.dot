all:
	for i in `ls tmp_*`; do cp $$i `echo $$i|sed "s/tmp_//g"` ; done

clean:
	ls | grep -v -E -e 'tmp_*' -e 'Makefile'| xargs rm -r