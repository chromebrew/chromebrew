require 'package'

class Shellcheck < Package
  description 'Static analysis tool for shell scripts'
  homepage 'https://www.shellcheck.net/'
  version '0.9.0'
  license 'GPL-3.0'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/koalaman/shellcheck/releases/download/v0.9.0/shellcheck-v0.9.0.linux.armv6hf.tar.xz',
     armv7l: 'https://github.com/koalaman/shellcheck/releases/download/v0.9.0/shellcheck-v0.9.0.linux.armv6hf.tar.xz',
       i686: 'https://github.com/koalaman/shellcheck/releases/download/v0.9.0/shellcheck-v0.9.0.linux.x86_64.tar.xz',
     x86_64: 'https://github.com/koalaman/shellcheck/releases/download/v0.9.0/shellcheck-v0.9.0.linux.x86_64.tar.xz'
  })
  source_sha256({
    aarch64: '03deed9ded9dd66434ccf9649815bcde7d275d6c9f6dcf665b83391673512c75',
     armv7l: '03deed9ded9dd66434ccf9649815bcde7d275d6c9f6dcf665b83391673512c75',
       i686: '700324c6dd0ebea0117591c6cc9d7350d9c7c5c287acbad7630fa17b1d4d9e2f',
     x86_64: '700324c6dd0ebea0117591c6cc9d7350d9c7c5c287acbad7630fa17b1d4d9e2f'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'shellcheck', "#{CREW_DEST_PREFIX}/bin/shellcheck", mode: 0o755
  end
end
