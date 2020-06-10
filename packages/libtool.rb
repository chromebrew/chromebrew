require 'package'

class Libtool < Package
  description 'GNU libtool is a generic library support script. Libtool hides the complexity of using shared libraries behind a consistent, portable interface.'
  homepage 'https://www.gnu.org/software/libtool/'
  version '2.4.6-4'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/libtool/libtool-2.4.6.tar.gz'
  source_sha256 'e3bd4d5d3d025a36c21dd6af7ea818a2afcd4dfc1ea5a17b39d7854bcd0c06e3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libtool-2.4.6-4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libtool-2.4.6-4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libtool-2.4.6-4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libtool-2.4.6-4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4d83d3c0d26b8aef3fba0d0d42feaa3fda736652a82ecfd24f4cdce384dc2b0c',
     armv7l: '4d83d3c0d26b8aef3fba0d0d42feaa3fda736652a82ecfd24f4cdce384dc2b0c',
       i686: '6eb2da330f7d23c34f41f5f7d94e1abc2f4b4feeb59d4c3886bfb00c8d34b4fb',
     x86_64: 'c0de77f4eeee3d662c9575b69125fa2778fe623ffad54de5ed296a01622e3724',
  })

  depends_on 'm4'

  def self.build
    system "./configure",
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
