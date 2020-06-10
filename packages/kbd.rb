require 'package'

class Kbd < Package
  description 'The kbd project contains tools for managing Linux console'
  homepage 'http://kbd-project.org/'
  version '2.0.4'
  compatibility 'all'
  source_url 'https://github.com/legionus/kbd/archive/2.0.4.tar.gz'
  source_sha256 '18f45ee8790ddb18363fcb98d60e715528b1c04aa4501bd69111609d43240d3e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/kbd-2.0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/kbd-2.0.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/kbd-2.0.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/kbd-2.0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0c53c9ac9dfae25f7ddbc308db92cff85b5343e594cfb5e9f73058340eda1401',
     armv7l: '0c53c9ac9dfae25f7ddbc308db92cff85b5343e594cfb5e9f73058340eda1401',
       i686: '448eb6055759318a5e87bbcf37e57bf636aaaa941b69c245f7db09d5b20c5720',
     x86_64: '7e16b148b66c8466ec6dc2685da62c83feb09a915e21ed0b5b7fb5d9be0e14a1',
  })

  depends_on 'linux_pam'

  def self.build
    system './autogen.sh'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           '--disable-static'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
