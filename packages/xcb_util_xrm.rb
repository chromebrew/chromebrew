require 'package'

class Xcb_util_xrm < Package
  description 'XCB utility functions for the X resource manager'
  homepage 'https://github.com/Airblader/xcb-util-xrm'
  version '1.3'
  compatibility 'all'
  source_url 'https://github.com/Airblader/xcb-util-xrm/releases/download/v1.3/xcb-util-xrm-1.3.tar.bz2'
  source_sha256 '301cf33701207ea8782d49f4cb6404abd8f2d64e16f242017fd720be7c900c85'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_xrm-1.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_xrm-1.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_xrm-1.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_xrm-1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd31a000b990d957f08f69ac0ab5b1c3edd6e24ac8039f69358332bfc01c2effd',
     armv7l: 'd31a000b990d957f08f69ac0ab5b1c3edd6e24ac8039f69358332bfc01c2effd',
       i686: '17f7ef76c78653b8b8b4829dca2b79a3de46e5e78ac1c144b738619a13a96553',
     x86_64: '681cec04642aee7c712d36207605771a660e487f671d4811fb39c311e91fc2f1',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
