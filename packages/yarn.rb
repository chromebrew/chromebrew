require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.22.17'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/yarnpkg/yarn/releases/download/v1.22.17/yarn-v1.22.17.tar.gz'
  source_sha256 '267982c61119a055ba2b23d9cf90b02d3d16c202c03cb0c3a53b9633eae37249'

  node_version=`node -v 2> /dev/null`.chomp
  depends_on 'nodebrew' unless "#{node_version}" != ""

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    FileUtils.rm_f ['bin/yarn.cmd','bin/yarnpkg.cmd']
    FileUtils.cp_r ['bin/','lib/'], "#{CREW_DEST_PREFIX}"
  end
end
