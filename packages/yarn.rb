require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.22.0'
  source_url 'https://github.com/yarnpkg/yarn/releases/download/v1.22.0/yarn-v1.22.0.tar.gz'
  source_sha256 'de8871c4e2822cba80d58c2e72366fb78567ec56e873493c9ca0cca76c60f9a5'

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
