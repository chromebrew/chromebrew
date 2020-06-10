require 'package'

class Gzrt < Package
  description 'The gzip Recovery Toolkit'
  homepage 'https://www.urbanophile.com/arenn/hacking/gzrt/gzrt.html'
  version '0.8'
  compatibility 'all'
  source_url 'https://www.urbanophile.com/arenn/hacking/gzrt/gzrt-0.8.tar.gz'
  source_sha256 'b0b7dc53dadd8309ad9f43d6d6be7ac502c68ef854f1f9a15bd7f543e4571fee'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gzrt-0.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gzrt-0.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gzrt-0.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gzrt-0.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '44e91f1d6773e9c0db2be22353d40507332514cb9315b16ccb25511ff06e04e4',
     armv7l: '44e91f1d6773e9c0db2be22353d40507332514cb9315b16ccb25511ff06e04e4',
       i686: '312e7643814a129065f2d03a49442283496142cc5c10dd7ec8bf90fdacc06b42',
     x86_64: '1a929a0a227e7b9498d72db847efe801700074a7be34b31d83e40f65825ffad9',
  })

  def self.build
    system 'make'
  end

  def self.install
    system "install -Dm755 gzrecover #{CREW_DEST_PREFIX}/bin/gzrecover"
    system "install -Dm644 gzrecover.1 #{CREW_DEST_PREFIX}/share/man/man1/gzrecover.1"
  end

  def self.postinstall
    puts
    puts "Type 'gzrecover -h' to get started.".lightblue
    puts
  end
end
