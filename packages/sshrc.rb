require 'package'

class Sshrc < Package
  description 'bring your .bashrc, .vimrc, etc. with you when you ssh'
  homepage 'https://github.com/cdown/sshrc'
  version '0.6.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/cdown/sshrc.git'
  git_hashtag version

  no_compile_needed

  def self.install
    FileUtils.install 'sshrc', "#{CREW_DEST_PREFIX}/bin/sshrc", mode: 0o755
    FileUtils.install 'moshrc', "#{CREW_DEST_PREFIX}/bin/moshrc", mode: 0o755
  end
end
