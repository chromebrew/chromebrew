require 'package'

class Ninja < Package
  description 'a small build system with a focus on speed'
  homepage 'https://ninja-build.org'
  version '1.7.2'
  source_url 'https://github.com/ninja-build/ninja/archive/v1.7.2.tar.gz'
  source_sha256 '2edda0a5421ace3cf428309211270772dd35a91af60c96f93f90df6bc41b16d9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ninja-1.7.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ninja-1.7.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ninja-1.7.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ninja-1.7.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3ff2fc875e7fce5f69880d0db463afe580aa2c963c36e07301348b3ea597f469',
     armv7l: '3ff2fc875e7fce5f69880d0db463afe580aa2c963c36e07301348b3ea597f469',
       i686: '45c4ea8662459b4846c09bf440982b3431162556b6d955268ebd2d7e5d2ba157',
     x86_64: '1dbb0af40656a2dda2d2e0c157f3860ee8ea9b79edff4a28b90f34d08d3f81d5',
  })

  depends_on 'python3'
  depends_on 'unzip'

  def self.build
    system "python3 configure.py --bootstrap"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp ninja #{CREW_DEST_DIR}/usr/local/bin/"
  end
end
