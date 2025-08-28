#/usr/bin/sh

_libdir=$(rpm -E '%_libdir')

for f in \
	$1/$_libdir/*.a \
	; do
	if grep -q '*' <<< "$f"; then continue; fi
	if grep -q '/\.' <<< "$f"; then continue; fi
	echo ${f#"$1/"}
done
