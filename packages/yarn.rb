require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.21.1'
  source_url 'https://github.com/yarnpkg/yarn/releases/download/v1.21.1/yarn-v1.21.1.tar.gz'
  source_sha256 'd1d9f4a0f16f5ed484e814afeb98f39b82d4728c6c8beaafb5abc99c02db6674'

  binary_url ({
  })
  binary_sha256 ({
  })

  node_version=`node -v 2> /dev/null`.chomp
  depends_on 'nodebrew' unless "#{node_version}" != ""

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    FileUtils.cp_r 'lib/', "#{CREW_DEST_PREFIX}"
    FileUtils.cp_r 'bin/', "#{CREW_DEST_PREFIX}"
  end
end
