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

  binary_sha256({
    aarch64: '1541e237594840c458b5a234278cb2150dc1f01d5e7d0c7932a8397e598a6837',
     armv7l: '1541e237594840c458b5a234278cb2150dc1f01d5e7d0c7932a8397e598a6837',
       i686: 'caa10c0cfa40b0c20454151433599482eee9a431a06856eeea1d4c0d455caa33',
     x86_64: 'dab1b1d174feb393035fb6e3ba38cb53282ec827916580e46f43b2eaaff83554'
  })

  depends_on 'git' # L

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
