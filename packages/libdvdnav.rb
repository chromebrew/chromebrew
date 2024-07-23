require 'package'

class Libdvdnav < Package
  description 'libdvdnav is a library that allows easy use of sophisticated DVD navigation features such as DVD menus, multiangle playback and even interactive DVD games.'
  homepage 'http://dvdnav.mplayerhq.hu/'
  version '6.1.1'
  compatibility 'all'
  license 'GPL-2'
  source_url 'https://get.videolan.org/libdvdnav/6.1.1/libdvdnav-6.1.1.tar.bz2'
  source_sha256 'c191a7475947d323ff7680cf92c0fb1be8237701885f37656c64d04e98d18d48'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '1663315253bf583fa15d29c094602053baa87927663124821a105e298c325746',
      armv7l: '1663315253bf583fa15d29c094602053baa87927663124821a105e298c325746',
        i686: 'f904448267fce9f2cf000d4b542c4eedca15cd26ebca5a75e07698a43c88b8ab',
      x86_64: 'ac31549a112b165b145668e64688f6cd0f30cd6c8ffe6356c454a1c5bdce1c88'
  })

  depends_on 'libdvdread'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
