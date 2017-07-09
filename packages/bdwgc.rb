require 'package'

class Bdwgc < Package
  description 'The Boehm-Demers-Weiser conservative C/C++ Garbage Collecto'
  homepage 'https://github.com/ivmai/bdwgc'
  version '7.6.0'
  source_url 'https://github.com/ivmai/bdwgc/files/1005477/gc-7.6.0.tar.gz'
  source_sha256 'a14a28b1129be90e55cd6f71127ffc5594e1091d5d54131528c24cd0c03b7d90'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/bdwgc-7.6.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/bdwgc-7.6.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/bdwgc-7.6.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/bdwgc-7.6.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'be29d91fd1e4ca65bc1f624f045b04b11178d689a9bd898c9a1e91b2e8cf8221',
     armv7l: 'be29d91fd1e4ca65bc1f624f045b04b11178d689a9bd898c9a1e91b2e8cf8221',
       i686: '6444b15b6cfa80b0e2ed0702944572b24ff2e6eb6fbe9baacc0acebdebe08c9d',
     x86_64: 'cfb243044ce59c9b36b862400f30008413c7f48da01a162364e5ec796f4690b6',
  })

  depends_on 'libatomic_ops'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end