#/bin/bash
ghc --make Main.hs

find . -name "*.o" -exec rm -f '{}' +
find . -name "*.hi" -exec rm -f '{}' +

find . -name "*~" -exec rm -f '{}' +

rm macro
mv Main macro

rm DEBIAN/usr/bin/macro
cp macro DEBIAN/usr/bin

rm DEBIAN/usr/share/doc/macro/README
cp README DEBIAN/usr/share/doc/macro/

rm *.deb
fakeroot dpkg -b DEBIAN/
dpkg-name *.deb

sudo dpkg -i *.deb

git add *
git add -u
