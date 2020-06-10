require 'package'

class Xcb_util < Package
  description 'The xcb-util package provides additional extensions to the XCB library.'
  homepage 'http://xcb.freedesktop.org'
  version '0.4.0'
  compatibility 'all'
  source_url 'https://xcb.freedesktop.org/dist/xcb-util-0.4.0.tar.bz2'
  source_sha256 '46e49469cb3b594af1d33176cd7565def2be3fa8be4371d62271fabb5eae50e9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util-0.4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util-0.4.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util-0.4.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util-0.4.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'df64c3efceda945c712d0ebbdc274e7052b3fb96364502ba1fe49e388c1121d7',
     armv7l: 'df64c3efceda945c712d0ebbdc274e7052b3fb96364502ba1fe49e388c1121d7',
       i686: '767d89654c0b7f960962126b293222c4358bf17cf0d759f7e85fe21412dd5ff1',
     x86_64: 'a33c276a097a95505cacdd18ac439dba037b37101d56cae3e5bd58deee6a1e66',
  })

  depends_on 'libxcb'
  depends_on 'util_macros'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
