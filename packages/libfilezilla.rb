require 'package'

class Libfilezilla < Package
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.23.0'
  compatibility 'all'
  source_url 'https://download.filezilla-project.org/libfilezilla/libfilezilla-0.23.0.tar.bz2'
  source_sha256 'adeac127fbd1714b22c828cdd27fc6c92e09fd1abcc96684bf30535fb8226852'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.23.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.23.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.23.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.23.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ca803dcb4dbc4b6d946c1e3b0110b9a2e11b5bf82d55f2fa9cdea40622927c22',
     armv7l: 'ca803dcb4dbc4b6d946c1e3b0110b9a2e11b5bf82d55f2fa9cdea40622927c22',
       i686: '56e280e263f0187c21b6f4f834790867fb37fef36e93adedeab5dbc3c6762b79',
     x86_64: '1215012524a037640996fc6d72936dbfcb7411f5cdedd289b6c9baf807a5c617',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
