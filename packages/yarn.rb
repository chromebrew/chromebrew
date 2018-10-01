require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.10.1'
  source_url 'https://github.com/yarnpkg/yarn/releases/download/v1.10.1/yarn-v1.10.1.tar.gz'
  source_sha256 '97bf147cb28229e66e4e3c5733a93c851bbcb0f10fbc72696ed011774f4c6f1b'

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
