#/bin/bash
ghc --make Main.hs

rm macro
mv Main macro

rm DEBIAN/usr/bin/macro
cp macro DEBIAN/usr/bin

rm DEBIAN/usr/share/doc/macro/README
cp README DEBIAN/usr/share/doc/macro/

rm *.deb
fakeroot dpkg -b DEBIAN/
dpkg-name *.deb

git add *
git add -u
