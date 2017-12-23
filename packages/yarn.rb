require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.3.2-20171127.1833'
  source_url 'https://nightly.yarnpkg.com/yarn-v1.3.2-20171127.1833.tar.gz'
  source_sha256 '36293f1327693a8742a9030aa8b8213eb7c33b298b7eb28d2d9b2efe93279060'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/yarn-1.3.2-20171127.1833-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/yarn-1.3.2-20171127.1833-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/yarn-1.3.2-20171127.1833-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/yarn-1.3.2-20171127.1833-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '14ec12edc8ef9e74a0fc7bf914e3e09f2eb90a70ef5a32bf858fe24dd42dcbcd',
     armv7l: '14ec12edc8ef9e74a0fc7bf914e3e09f2eb90a70ef5a32bf858fe24dd42dcbcd',
       i686: 'fe3ac396402804f42e9d74bf36950a6fed8df5b3a8b6e50c666b8c0ff7a69b1f',
     x86_64: '2f3c453523d498376bf5182fb01eaebb1f269dd32cb8dae40eb7515386dec3e6',
  })

  node_version=`node -v 2> /dev/null`
  depends_on 'nodebrew' unless "#{node_version}" != ""

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}"
    system "cp -r lib/ #{CREW_DEST_PREFIX}"
    system "cp -r bin/ #{CREW_DEST_PREFIX}"
  end
end
