require 'package'

class Git_prompt < Package
  description 'Display the git branch and status in the command prompt'
  homepage 'https://github.com/git/git'
  version '2.32.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'

  reload_source

  def self.build
    system "curl -#LO https://raw.githubusercontent.com/git/git/v#{version}/contrib/completion/git-prompt.sh"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest(File.read('git-prompt.sh')) == '1fbced3fe345ec14f828ffb876e191d69457cccc807c70f54c9ba48cb2a6620e'
    git_env = <<~EOF

      GIT_PS1_SHOWDIRTYSTATE=yes
      GIT_PS1_SHOWSTASHSTATE=yes
      GIT_PS1_SHOWUNTRACKEDFILES=yes
      GIT_PS1_SHOWUPSTREAM=auto
      GIT_PS1_DESCRIBE_STYLE=default
      GIT_PS1_SHOWCOLORHINTS=yes

      PS1='\\[\\033[1;34m\\]\\u@\\h \\[\\033[1;33m\\]\\w \\[\\033[1;31m\\]$(__git_ps1 "(%s)")\\[\\033[0m\\]\\$ '
    EOF
    File.write('git-prompt.sh', git_env, mode: 'a')
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"
    FileUtils.install 'git-prompt.sh', "#{CREW_DEST_PREFIX}/etc/bash.d/git-prompt.sh", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "\ncd /path/to/git/repo and you should see the branch displayed in the prompt\n".lightblue
  end
end
