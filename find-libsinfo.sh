#/usr/bin/sh

for f in \
	$1/$_libdir/*.so.*
	; do
	if grep -q '*' <<< "$f"; then continue; fi
	if grep -q '/\.' <<< "$f"; then continue; fi
	echo ${f#"$1/"}
done
