#/usr/bin/sh

buildroot=$1

_includedir=$(rpm -E '%_includedir')
_libdir=$(rpm -E '%_libdir')

for f in \
	$buildroot/$_includedir/* \
	$buildroot/$_libdir/*.so \
	$buildroot/$_libdir/pkgconfig/*.pc \
	$buildroot//usr/share/gir-1.0/*.gir \
	; do
	if grep -q '*' <<< "$f"; then continue; fi
	if grep -q '/\.' <<< "$f"; then continue; fi
	echo ${f#"$buildroot/"}
done
