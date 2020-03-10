require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.22.4'
  source_url 'https://github.com/yarnpkg/yarn/releases/download/v1.22.4/yarn-v1.22.4.tar.gz'
  source_sha256 'bc5316aa110b2f564a71a3d6e235be55b98714660870c5b6b2d2d3f12587fb58'

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
