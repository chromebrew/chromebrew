require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.22.22'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://github.com/yarnpkg/yarn/releases/download/v#{version}/yarn-v#{version}.tar.gz"
  source_sha256 '88268464199d1611fcf73ce9c0a6c4d44c7d5363682720d8506f6508addf36a0'

  node_version = `node -v 2> /dev/null`.chomp
  depends_on 'nodebrew' unless node_version.to_s != ''

  no_compile_needed

  def self.patch
    # Fix for fhs compliance.
    system "sed -i 's,/lib/,/lib#{CREW_LIB_SUFFIX}/,' bin/yarn.js" if ARCH.eql?('x86_64')
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.rm_f ['bin/yarn.cmd', 'bin/yarnpkg.cmd']
    FileUtils.mv 'bin/', CREW_DEST_PREFIX
    FileUtils.mv Dir['lib/*'], CREW_DEST_LIB_PREFIX
  end
end
