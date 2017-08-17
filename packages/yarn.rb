require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.0.0-20170808.1058'
  source_url 'https://nightly.yarnpkg.com/yarn-v1.0.0-20170808.1058.tar.gz'
  source_sha256 '7056c5ee12aa8d014d59b377be2e494ce49a6059e2678d8f79f1fc9904eb008b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/yarn-1.0.0-20170808.1058-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/yarn-1.0.0-20170808.1058-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/yarn-1.0.0-20170808.1058-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/yarn-1.0.0-20170808.1058-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4efa9e90e6d9da2d5a625a3efc535df5cb8241e27fb0c87f00225e1515cd4d1c',
     armv7l: '4efa9e90e6d9da2d5a625a3efc535df5cb8241e27fb0c87f00225e1515cd4d1c',
       i686: 'b90ff3133e1b1005f9566ee2b8d266df0607c7ab18da19c23ee1c9e3a7d821be',
     x86_64: '4ac8f1c457827fa1e3c9df0ecb4c79ebd84617329cd7e8981437aabf5a553385',
  })

  node_version=`node -v 2> /dev/null`
  depends_on 'node' unless "#{node_version}" != ""

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local"
    system "cp -r lib/ #{CREW_DEST_DIR}/usr/local"
    system "cp -r bin/ #{CREW_DEST_DIR}/usr/local"
  end
end
