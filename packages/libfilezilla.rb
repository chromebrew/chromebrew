require 'package'

class Libfilezilla < Package
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.22.0'
  compatibility 'all'
  source_url 'https://download.filezilla-project.org/libfilezilla/libfilezilla-0.22.0.tar.bz2'
  source_sha256 'c5f660c4b339ed6a9e89ec0bafd5d39ba53cb3a3b52051bc571bb74e03ef8f7a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.22.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.22.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.22.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.22.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a86846ce4e33b0f3cbf474962491b04cb9f0536e7d1f6c6d15c9c149f1ec497f',
     armv7l: 'a86846ce4e33b0f3cbf474962491b04cb9f0536e7d1f6c6d15c9c149f1ec497f',
       i686: '372b9c3d341d6cfc68c47056b6e3d4f46826a1fa6cb1a85f94b895d99fa82cf5',
     x86_64: '490464fc52e9639e0ff88fc40efbc2064487f9b5344301be92565b15a88bffb8',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
