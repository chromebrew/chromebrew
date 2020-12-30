require 'package'

class Libepoxy < Package
  description 'Epoxy is a library for handling OpenGL function pointer management for you'
  homepage 'https://github.com/anholt/libepoxy'
  version '1.5.5'
  compatibility 'all'
  source_url 'https://github.com/anholt/libepoxy/releases/download/1.5.5/libepoxy-1.5.5.tar.xz'
  source_sha256 '261663db21bcc1cc232b07ea683252ee6992982276536924271535875f5b0556'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libepoxy-1.5.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libepoxy-1.5.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libepoxy-1.5.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libepoxy-1.5.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'de87478a3eecf1b1ab3b23441b87ca0c81ee26af507b7223dffb51097aa15e07',
     armv7l: 'de87478a3eecf1b1ab3b23441b87ca0c81ee26af507b7223dffb51097aa15e07',
       i686: '39b1ca812fd683eda89f16a2b9f5be0a63425ea710f31abf5e9f208ba650b986',
     x86_64: 'e2e6aeded9388b562742d958d047365157a7a4965a4b6147bc9178060a789bd6',
  })

  depends_on 'mesa'
  depends_on 'python3'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
