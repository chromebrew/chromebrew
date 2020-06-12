require 'package'

class Recode < Package
  description 'Charset converter tool and library'
  homepage 'https://github.com/pinard/Recode'
  # This version is from the master branch since the stable versions could not be compiled
  compatibility 'all'
  version '2d7092a'
  source_url 'https://github.com/pinard/Recode/archive/2d7092a9999194fc0e9449717a8048c8d8e26c18.tar.gz'
  source_sha256 'd7de37aa4793ec00b042a0315f142281a1dc480f6f6d7cb2cd2568e58c4f2e87'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/recode-2d7092a-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/recode-2d7092a-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/recode-2d7092a-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/recode-2d7092a-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3084a139559698dcfeb48f372cf05be2f38c00a65a657b946ff9afc8d2e639f4',
     armv7l: '3084a139559698dcfeb48f372cf05be2f38c00a65a657b946ff9afc8d2e639f4',
       i686: 'addbb2ff38b1bb89065942da55144fae83dd372be69c0c6bc77e0b20c8e943e3',
     x86_64: '6d1613a2f31ede4ca9e57049c4355b01862e3d182e654e36dd66643eacc35ede',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
