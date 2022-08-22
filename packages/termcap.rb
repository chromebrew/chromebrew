require 'package'

class Termcap < Package
  description 'A library for sending terminal control codes.'
  homepage 'https://www.gnu.org/software/termutils/'
  version '1.3.1-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/termcap/termcap-1.3.1.tar.gz'
  source_sha256 '91a0e22e5387ca4467b5bcb18edf1c51b930262fd466d5fda396dd9d26719100'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/termcap/1.3.1-1_armv7l/termcap-1.3.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/termcap/1.3.1-1_armv7l/termcap-1.3.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/termcap/1.3.1-1_i686/termcap-1.3.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/termcap/1.3.1-1_x86_64/termcap-1.3.1-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c009c6ce4f03e6897c656f2e45a6d386ecbd06b78b766b054fa96a981611cc45',
     armv7l: 'c009c6ce4f03e6897c656f2e45a6d386ecbd06b78b766b054fa96a981611cc45',
       i686: '3bea54475c13ea40aba0a85152414699d32b60d525459afaf686d3fe0142ddc8',
     x86_64: 'f57bd2e1b4cd1893ce97d3038c9fe8a67664ef448c8249b67148749da350542c'
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "install -Dm644 libtermcap.a #{CREW_DEST_LIB_PREFIX}/libtermcap.a"
    system "ranlib #{CREW_DEST_LIB_PREFIX}/libtermcap.a"
    system "install -Dm644 termcap.h #{CREW_DEST_PREFIX}/include/termcap.h"
    system "for f in termcap.info*; do install -Dm644 $f #{CREW_DEST_PREFIX}/info/$f; done"
  end
end
