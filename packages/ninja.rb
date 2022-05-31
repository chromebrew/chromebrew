require 'package'

class Ninja < Package
  description 'a small build system with a focus on speed'
  homepage 'https://ninja-build.org'
  @_ver = '1.11.0'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ninja-build/ninja.git'
  git_hashtag 'v' + @_ver

  depends_on 're2c' => :build
  depends_on 'emacs' => :build

  def self.patch
    system 'filefix'
  end

  def self.build
    system "python3 configure.py --bootstrap"
    system 'emacs -Q --batch -f batch-byte-compile misc/ninja-mode.el'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/doc/ninja/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/emacs/site-lisp/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/vim/vimfiles/syntax/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/bash-completion/completions/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/zsh/site-functions/"

    FileUtils.install 'ninja', "#{CREW_DEST_PREFIX}/bin/ninja", mode: 0o755
    FileUtils.install 'doc/manual.asciidoc', "#{CREW_DEST_PREFIX}/share/doc/ninja/manual.asciidoc"
    FileUtils.install 'misc/ninja-mode.el', "#{CREW_DEST_PREFIX}/share/emacs/site-lisp/ninja-mode.el"
    FileUtils.install 'misc/ninja-mode.elc', "#{CREW_DEST_PREFIX}/share/emacs/site-lisp/ninja-mode.elc"
    FileUtils.install 'misc/ninja.vim', "#{CREW_DEST_PREFIX}/share/vim/vimfiles/syntax/ninja.vim"
    FileUtils.install 'misc/bash-completion', "#{CREW_DEST_PREFIX}/share/bash-completion/completions/ninja"
    FileUtils.install 'misc/zsh-completion', "#{CREW_DEST_PREFIX}/share/zsh/site-functions/_ninja"
  end

  def self.check
    system 'python3 configure.py'
    system './ninja ninja_test'
    system './ninja_test'
  end
end
