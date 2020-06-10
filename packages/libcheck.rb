require 'package'

class Libcheck < Package
  description 'A unit testing framework for C'
  homepage 'https://github.com/libcheck/check'
  version '0.13.0'
  compatibility 'all'
  source_url 'https://github.com/libcheck/check/releases/download/0.13.0/check-0.13.0.tar.gz'
  source_sha256 'c4336b31447acc7e3266854f73ec188cdb15554d0edd44739631da174a569909'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libcheck-0.13.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libcheck-0.13.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libcheck-0.13.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libcheck-0.13.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '71a129c63ce759b17a6a9ce7c30eecadb633a24242170d9a6646a9c45c64eac4',
     armv7l: '71a129c63ce759b17a6a9ce7c30eecadb633a24242170d9a6646a9c45c64eac4',
       i686: '48d3bea93e956e8089ba520a48761d40148be6009aa4d93f801e4f6627e75755',
     x86_64: '9522b0a5173a563716f2f435d1ef26e61f39eebea16c6ece97aea037a5db9ba3',
  })

  def self.build
    system 'autoreconf --install'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
