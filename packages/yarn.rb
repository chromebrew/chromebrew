require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.22.21'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/yarnpkg/yarn/releases/download/v1.22.21/yarn-v1.22.21.tar.gz'
  source_sha256 'a55bb4e85405f5dfd6e7154a444e7e33ad305d7ca858bad8546e932a6688df08'

  node_version = `node -v 2> /dev/null`.chomp
  depends_on 'nodebrew' unless node_version.to_s != ''

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.rm_f ['bin/yarn.cmd', 'bin/yarnpkg.cmd']
    FileUtils.cp_r ['bin/', 'lib/'], CREW_DEST_PREFIX
  end
end
