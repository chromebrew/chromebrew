require 'package'

class Lft < Package
  description "LFT, short for Layer Four Traceroute, is a sort of 'traceroute' that often works much faster (than the commonly-used Van Jacobson method) and goes through many configurations of packet-filters (firewalls)."
  homepage 'http://pwhois.org/lft/'
  version '3.79'
  compatibility 'all'
  source_url 'https://fossies.org/linux/privat/lft-3.79.tar.gz'
  source_sha256 '08e5c7973551b529c850bffbc7152c4e5f0bcb1f07ebbb39151a7dc9a3bf9de0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lft-3.79-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lft-3.79-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lft-3.79-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lft-3.79-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6a3c32976a7384458cc11ba2ad0c29c44cc14d2effc3cb6d78b97c64ab2164e8',
     armv7l: '6a3c32976a7384458cc11ba2ad0c29c44cc14d2effc3cb6d78b97c64ab2164e8',
       i686: 'e5dc39f4dfe87b0c646b52040d4ed435e6692b0debfa94f5412462867d234229',
     x86_64: 'c8d1a84ea31451c0dab2dbde533da95315ee71c7bd7644fb3daa6b86facc259c',
  })

  depends_on 'libpcap'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
