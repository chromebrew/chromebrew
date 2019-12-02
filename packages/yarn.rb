require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.21.0'
  source_url 'https://github.com/yarnpkg/yarn/releases/download/v1.21.0/yarn-v1.21.0.tar.gz'
  source_sha256 'dd17d4e5bc560aa28140038a31fa50603ef76b710fee44e5ec5efbea7ad24c61'

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
