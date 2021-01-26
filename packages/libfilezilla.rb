require 'package'

class Libfilezilla < Package
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.26-1'
  compatibility 'all'
  source_url 'https://download.filezilla-project.org/libfilezilla/libfilezilla-0.26.0.tar.bz2'
  source_sha256 '17ed226593e8e466ce3c3f8ce583b36c79f163189ead54d631613cc3da5c80bd'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.26-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.26-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.26-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.26-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'feed1d31cf4d1939190e38d6649610250b76dd8242adfd644672d6e2530c5d66',
      armv7l: 'feed1d31cf4d1939190e38d6649610250b76dd8242adfd644672d6e2530c5d66',
        i686: '29cc4771df9bf63a0723ec43f1d5fa18ba1e17c93543888ba3fc6a2811d9910b',
      x86_64: 'c442aadbe2e23252a3abcdcef79b0e771c29f4d940541d263f32dcddcabc030f',
  })

  depends_on 'p11kit'

  def self.patch
    system 'filefix'
  end

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
