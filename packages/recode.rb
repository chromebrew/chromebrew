require 'package'

class Recode < Package
  description 'Charset converter tool and library'
  homepage 'https://github.com/pinard/Recode'
  # This version is from the master branch since the stable versions could not be compiled
  version '2d7092'
  source_url 'https://github.com/pinard/Recode/archive/2d7092a9999194fc0e9449717a8048c8d8e26c18.tar.gz'
  source_sha256 'd7de37aa4793ec00b042a0315f142281a1dc480f6f6d7cb2cd2568e58c4f2e87'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/recode-2d7092-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/recode-2d7092-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/recode-2d7092-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/recode-2d7092-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3a60e63b891f41f3f24d9cf7ad84289168514cc1171e0f1e24767ce3a0db058a',
     armv7l: '3a60e63b891f41f3f24d9cf7ad84289168514cc1171e0f1e24767ce3a0db058a',
       i686: '1b44a3dab2e9347064f4bc97f6af249dc0b8b975e94f358de34b2b60788c9a36',
     x86_64: '6add7066297ffafc3ffd448feeda01074268b22bfabf95d2f516c5b16aca3019',
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
