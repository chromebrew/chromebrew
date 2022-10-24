require 'package'

class Shellcheck < Package
  description 'Static analysis tool for shell scripts'
  homepage 'https://www.shellcheck.net/'
  version '0.8.0'
  license 'GPL-3.0'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/koalaman/shellcheck/releases/download/v0.8.0/shellcheck-v0.8.0.linux.armv6hf.tar.xz',
     armv7l: 'https://github.com/koalaman/shellcheck/releases/download/v0.8.0/shellcheck-v0.8.0.linux.armv6hf.tar.xz',
       i686: 'https://github.com/koalaman/shellcheck/releases/download/v0.8.0/shellcheck-v0.8.0.linux.x86_64.tar.xz',
     x86_64: 'https://github.com/koalaman/shellcheck/releases/download/v0.8.0/shellcheck-v0.8.0.linux.x86_64.tar.xz'
  })
  source_sha256({
    aarch64: '17857c8a0a8f4001aa9638732991cbb6e85c4a410500b11e2e0a98d9858afca8',
     armv7l: '17857c8a0a8f4001aa9638732991cbb6e85c4a410500b11e2e0a98d9858afca8',
       i686: 'ab6ee1b178f014d1b86d1e24da20d1139656c8b0ed34d2867fbb834dad02bf0a',
     x86_64: 'ab6ee1b178f014d1b86d1e24da20d1139656c8b0ed34d2867fbb834dad02bf0a'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'shellcheck', "#{CREW_DEST_PREFIX}/bin/shellcheck", mode: 0o755
  end
end
