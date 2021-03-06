EAPI=4
inherit eutils

EAP_VERSION='EAP-172.2465.7'

HOMEPAGE="http://www.jetbrains.com/phpstorm/"
DESCRIPTION="PhpStorm"
SRC_URI="https://download.jetbrains.com/webide/PhpStorm-${EAP_VERSION:-${PV}}.tar.gz"

if [[ x${EAP_VERSION} != 'x' ]]; then
	KEYWORDS="x86 amd64"
else
	KEYWORDS="~x86 ~amd64"
fi

PROGNAME="PHP Storm"

RESTRICT="strip mirror"
DEPEND=">=virtual/jre-1.6"
SLOT="0"
S=${WORKDIR}

src_install() {
	dodir /opt/${PN}

	cd PhpStorm*/
	sed -i 's/IS_EAP="true"/IS_EAP="false"/' bin/phpstorm.sh
	insinto /opt/${PN}
	doins -r *

	fperms a+x /opt/${PN}/bin/phpstorm.sh || die "Chmod failed"
	fperms a+x /opt/${PN}/bin/fsnotifier || die "Chmod failed"
	fperms a+x /opt/${PN}/bin/fsnotifier64 || die "Chmod failed"
	fperms a+x /opt/${PN}/bin/fsnotifier-arm || die "Chmod failed"
	dosym /opt/${PN}/bin/phpstorm.sh /usr/bin/${PN}

	mv "bin/webide.png" "bin/${PN}.png"
	doicon "bin/${PN}.png"
	make_desktop_entry ${PN} "${PROGNAME}" "${PN}"
}

pkg_postinst() {
    elog "Run /usr/bin/${PN}"
}


