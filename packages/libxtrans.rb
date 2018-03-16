require 'package'

class Libxtrans < Package
  description 'transpot library for the X window system'
  homepage 'https://x.org'
  version '1.3.5-0'
  source_url 'https://www.x.org/archive/individual/lib/xtrans-1.3.5.tar.gz'
  source_sha256 'b7a577c1b6c75030145e53b4793db9c88f9359ac49e7d771d4385d21b3e5945d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxtrans-1.3.5-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxtrans-1.3.5-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxtrans-1.3.5-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxtrans-1.3.5-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1733f56bfe385bd68cdc430070a93f6eb6ddea511f4a994788215e00c797ca7b',
     armv7l: '1733f56bfe385bd68cdc430070a93f6eb6ddea511f4a994788215e00c797ca7b',
       i686: '3671105eeb2208f79fce5cdbae80722f63913d3bc13e6eb86ec41c6a5db19cf3',
     x86_64: '63e17dadab029b422ae76939b53a0a9a38c61e654398270c34b23dd0165705db',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
