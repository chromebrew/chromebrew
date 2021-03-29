require 'package'

class Libgc < Package
  description 'libgc is a library for garbage collection in Rust.'
  homepage 'https://github.com/softdevteam/libgc'
  version '2.1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://httpredir.debian.org/debian/pool/main/libg/libgc/libgc_8.0.4.orig.tar.gz'
  source_sha256 '436a0ddc67b1ac0b0405b61a9675bca9e075c8156f4debd1d06f3a56c7cd289d'
  
  def self.build
    system "./configure #{CREW_OPTIONS} \
            --enable-static \
            --enable-shared \
            --enable-docs"
    system "make"
  end
  
  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
