require 'package'

class Bats < Package
  description 'Bash Automated Testing System'
  homepage 'https://github.com/sstephenson/bats'
  version '0.4.0'
  compatibility 'all'
  source_url 'https://github.com/sstephenson/bats/archive/v0.4.0.tar.gz'
  source_sha256 '480d8d64f1681eee78d1002527f3f06e1ac01e173b761bc73d0cf33f4dc1d8d7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bats-0.4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bats-0.4.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bats-0.4.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bats-0.4.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd551d8924ac131c93d5f7ae97b67536e3d898f6737d9accd71b979805162fa75',
     armv7l: 'd551d8924ac131c93d5f7ae97b67536e3d898f6737d9accd71b979805162fa75',
       i686: 'eabf41741fc22656b88807325d0345d7001b993aec01e38ffa263181c6b29efa',
     x86_64: '8170fb0e171d68a1277c96f400845a42abfedd2d7b8edf761cd99b4088e7e56b',
  })

  def self.install
    system "./install.sh #{CREW_DEST_PREFIX}"
  end
end
