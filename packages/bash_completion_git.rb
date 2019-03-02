require 'package'

class Bash_completion_git < Package
  description 'Adds completion for git to package bash_completion'
  homepage 'https://github.com/git/git'
  version '2.21'
  source_url 'https://raw.githubusercontent.com/git/git/8104ec994ea3849a968b4667d072fedd1e688642/contrib/completion/git-completion.bash'
  source_sha256 '54bfe8b6a61062c462d15d6c483ece622d3716ad7806fdc40c4d0f576cae67cd'

  depends_on 'bash_completion'

  def self.install
    system 'cp', "#{CREW_BREW_DIR}/git-completion.bash", './git'
    system 'install', '-Dm644', 'git', "#{CREW_DEST_PREFIX}/share/bash-completion/completions/git"
  end
end
