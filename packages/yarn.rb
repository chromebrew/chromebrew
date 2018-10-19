require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.12.0'
  source_url 'https://github.com/yarnpkg/yarn/releases/download/v1.12.0/yarn-v1.12.0.tar.gz'
  source_sha256 '90c40e80743eebbce63d83c539f3ca97e24b30eb2d98b9858e37e13fbe8fafdc'

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
