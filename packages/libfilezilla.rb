require 'package'

class Libfilezilla < Package
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.19.3'
  source_url 'https://download.filezilla-project.org/libfilezilla/libfilezilla-0.19.3.tar.bz2'
  source_sha256 'a43d49f86d5550e9a81aee2394bac066333d5bb47943e92c629cb9d52037b43a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.19.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.19.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.19.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.19.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4dcaebe877dfcb68dc6dda313e7121c6c220979716eef419960e88529caf6eca',
     armv7l: '4dcaebe877dfcb68dc6dda313e7121c6c220979716eef419960e88529caf6eca',
       i686: '7e4e7f219a6447fcb7ca6ce3010fa560122853e0831de19b8d89c58afd9bfd30',
     x86_64: 'cad527db909fae46126213f99de2ec8a1bff297be41068ebb133f61fbf7492e6',
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
