require 'package'
require_relative 'git'

class Git_prompt < Package
  description 'Display the git branch and status in the command prompt'
  homepage 'https://github.com/git/git'
  version Git.version
  license 'GPL-2'
  compatibility 'all'
  source_url Git.source_url
  source_sha256 Git.source_sha256
  binary_compression 'tar.zst'

  depends_on 'git' # L

  no_compile_needed
  print_source_bashrc

  def self.build
    git_env = <<~EOF

      GIT_PS1_SHOWDIRTYSTATE=yes
      GIT_PS1_SHOWSTASHSTATE=yes
      GIT_PS1_SHOWUNTRACKEDFILES=yes
      GIT_PS1_SHOWUPSTREAM=auto
      GIT_PS1_DESCRIBE_STYLE=default
      GIT_PS1_SHOWCOLORHINTS=yes

      PS1='\\[\\033[1;34m\\]\\u@\\H \\[\\033[1;33m\\]\\w \\[\\033[1;31m\\]$(__git_ps1 "(%s)")\\[\\033[0m\\]\\$ '
    EOF
    File.write('contrib/completion/git-prompt.sh', git_env, mode: 'a')
  end

  def self.install
    FileUtils.install 'contrib/completion/git-prompt.sh', "#{CREW_DEST_PREFIX}/etc/bash.d/git-prompt.sh", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "\ncd /path/to/git/repo and you should see the branch displayed in the prompt\n".lightblue
  end
end
