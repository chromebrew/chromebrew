require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.3.2-20171127.1833'
  source_url 'https://nightly.yarnpkg.com/yarn-v1.3.2-20171127.1833.tar.gz'
  source_sha256 '36293f1327693a8742a9030aa8b8213eb7c33b298b7eb28d2d9b2efe93279060'

  binary_url ({
  })
  binary_sha256 ({
  })

  node_version=`node -v 2> /dev/null`
  depends_on 'nodebrew' unless "#{node_version}" != ""

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}"
    system "cp -r lib/ #{CREW_DEST_PREFIX}"
    system "cp -r bin/ #{CREW_DEST_PREFIX}"
  end
end
