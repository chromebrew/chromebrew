require 'package'

class Libfilezilla < Package
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.22.0'
  source_url 'https://download.filezilla-project.org/libfilezilla/libfilezilla-0.22.0.tar.bz2'
  source_sha256 'c5f660c4b339ed6a9e89ec0bafd5d39ba53cb3a3b52051bc571bb74e03ef8f7a'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
