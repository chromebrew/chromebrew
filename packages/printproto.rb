require 'package'

class Printproto < Package
  description 'Xprint build headers'
  homepage 'https://xorg.freedesktop.org'
  version '1.0.5-1'
  compatibility 'all'
  source_url 'https://xorg.freedesktop.org/releases/individual/proto/printproto-1.0.5.tar.bz2'
  source_sha256 '1298316cf43b987365ab7764d61b022a3d7f180b67b423eed3456862d155911a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/printproto-1.0.5-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/printproto-1.0.5-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/printproto-1.0.5-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/printproto-1.0.5-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c58de8b1d8ad64d5791d58efddbd3dde5a75e8b02bc78b3ddd2b1812d179d78f',
     armv7l: 'c58de8b1d8ad64d5791d58efddbd3dde5a75e8b02bc78b3ddd2b1812d179d78f',
       i686: 'e2ca555a5135201781ae329e41acae5aae9a040ac7d67674dd5420f06e4cfb97',
     x86_64: 'd4aadf7ee2ede4b9101d51beadb8ea3c185cbb42a056756cd3f6e544008e2acb',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
