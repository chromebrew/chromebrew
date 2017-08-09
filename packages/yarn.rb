require 'package'

NODE_VERSION = `node -v 2> /dev/null`

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.0.0-20170808.1058'
  source_url 'https://nightly.yarnpkg.com/yarn-v1.0.0-20170808.1058.tar.gz'
  source_sha256 '7056c5ee12aa8d014d59b377be2e494ce49a6059e2678d8f79f1fc9904eb008b'

  depends_on 'nodebrew' unless "#{NODE_VERSION}" != ""

  def self.install
    system "nodebrew install-binary latest && nodebrew use latest" unless "#{NODE_VERSION}" != ""
    system "mkdir -p #{CREW_DEST_DIR}/usr/local"
    system "cp -r lib/ #{CREW_DEST_DIR}/usr/local"
    system "cp -r bin/ #{CREW_DEST_DIR}/usr/local"
  end
end
