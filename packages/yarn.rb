require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.22.5'
  compatibility 'all'
  source_url 'https://github.com/yarnpkg/yarn/releases/download/v1.22.5/yarn-v1.22.5.tar.gz'
  source_sha256 'c664fb4692e4dfea750a37a533780834b40198c00cef4bbc5e8c14abab2ac141'

  node_version=`node -v 2> /dev/null`.chomp
  depends_on 'nodebrew' unless "#{node_version}" != ""

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    FileUtils.cp_r 'lib/', "#{CREW_DEST_PREFIX}"
    FileUtils.cp_r 'bin/', "#{CREW_DEST_PREFIX}"
  end
end
