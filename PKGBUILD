developer=http://grasscommons.org/
url=http://wagn.org/
maintainer=${developer}
pkgname=decko
pkgver=1.18.3
pkgrel=1
pkgdesc="Wiki platform for collaborating to build custom web systems"
arch=('any')
license=("GPL")
source=("https://github.com/wagn/wagn/archive/v${pkgver}.zip")
options=('!strip')
sha512sums=('cfd7a80f5c1c74210cd29af9c42f2402fe5f48cb92955ac72f683ea214ec4f627b982d56d609e5340864544a680ece2088d59988df92eee017c08aa0378dda7e')

package() {
# Manifest
    mkdir -p ${pkgdir}/var/lib/ubos/manifests
    install -m0644 ${startdir}/ubos-manifest.json ${pkgdir}/var/lib/ubos/manifests/${pkgname}.json

# Icons
    mkdir -p ${pkgdir}/srv/http/_appicons/$pkgname
    install -m644 ${startdir}/appicons/{72x72,144x144}.png ${pkgdir}/srv/http/_appicons/$pkgname/

# Data directory
    mkdir -p ${pkgdir}/var/lib/${pkgname}

# Templates
# TODO
#    mkdir -p ${pkgdir}/usr/share/${pkgname}/tmpl
#    cp ${startdir}/tmpl/*.tmpl ${pkgdir}/usr/share/${pkgname}/tmpl

# Code
    mkdir -p ${pkgdir}/usr/share/${pkgname}/wagn
    cp -r -p ${srcdir}/wagn-${pkgver}/* ${pkgdir}/usr/share/${pkgname}/wagn/

}
