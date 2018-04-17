require 'package'

class Fribidi < Package
  description 'GNU FriBidi is an implementation of the Unicode Bidirectional Algorithm (bidi).'
  homepage 'https://www.fribidi.org/'
  version '1.0.1'
  source_url 'https://github.com/fribidi/fribidi/releases/download/v1.0.1/fribidi-1.0.1.tar.bz2'
  source_sha256 'c1b182d70590b6cdb5545bab8149de33b966800f27f2d9365c68917ed5a174e4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fribidi-1.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fribidi-1.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fribidi-1.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fribidi-1.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd2c2acf788e0fc1c3d5330ead4bf2f184c7667847c51fe6e8da183cba9e77748',
     armv7l: 'd2c2acf788e0fc1c3d5330ead4bf2f184c7667847c51fe6e8da183cba9e77748',
       i686: '0b0515f77ac80bfd3cf9332b3bc5980e04e3664e9b2f5957f4f12ba48f9dd02a',
     x86_64: 'f408ec87bb6df6e4d375ba9b90d5d79cbdef7180e6fb69bdf31610756ae31f7d',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
