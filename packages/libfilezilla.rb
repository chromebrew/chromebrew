require 'package'

class Libfilezilla < Package
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.18.0'
  source_url 'https://download.filezilla-project.org/libfilezilla/libfilezilla-0.18.0.tar.bz2'
  source_sha256 '577a663b5dcf7f44e76a4208f11d6e7c4325c8f45fe15be8588de86eb75f9f3c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.18.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.18.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.18.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.18.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd35b79ea3d8d2854986c3880bf6b39792914b7c90a8e41c3dc8af1616a897ca9',
     armv7l: 'd35b79ea3d8d2854986c3880bf6b39792914b7c90a8e41c3dc8af1616a897ca9',
       i686: '58437bfb3359931446837389c2116d3d4f997069d1a39a901ce6bfc47ef652e5',
     x86_64: '87dd446e4984dedb2ffb7f704a3458a29c64fd8cba33d49ac7bdd3241d53bc7a',
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
