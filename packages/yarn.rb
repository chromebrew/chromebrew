require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.22.19'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/yarnpkg/yarn/releases/download/v1.22.19/yarn-v1.22.19.tar.gz'
  source_sha256 '732620bac8b1690d507274f025f3c6cfdc3627a84d9642e38a07452cc00e0f2e'

  node_version = `node -v 2> /dev/null`.chomp
  depends_on 'nodebrew' unless node_version.to_s != ''

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.rm_f ['bin/yarn.cmd', 'bin/yarnpkg.cmd']
    FileUtils.cp_r ['bin/', 'lib/'], CREW_DEST_PREFIX
  end
end
