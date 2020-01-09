require 'package'

class Libfilezilla < Package
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.19.3'
  source_url 'https://download.filezilla-project.org/libfilezilla/libfilezilla-0.19.3.tar.bz2'
  source_sha256 'a43d49f86d5550e9a81aee2394bac066333d5bb47943e92c629cb9d52037b43a'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
