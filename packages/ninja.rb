require 'package'

class Ninja < Package
  description 'a small build system with a focus on speed'
  homepage 'https://ninja-build.org'
  @_ver = '1.11.0'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ninja-build/ninja.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ninja/1.11.0_x86_64/ninja-1.11.0-chromeos-x86_64.tar.zst',
   aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ninja/1.11.0_armv7l/ninja-1.11.0-chromeos-armv7l.tar.zst',
    armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ninja/1.11.0_armv7l/ninja-1.11.0-chromeos-armv7l.tar.zst',
      i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ninja/1.11.0_i686/ninja-1.11.0-chromeos-i686.tar.zst'
  })
  binary_sha256({
    x86_64: '40ee7476d70e15874acb59b43e4e379c67cc65793ead2af6fbd67331f06193ff',
   aarch64: '7b87e31690157dc58eb495a8e6daf2f334866a8f5aa0dda171cb6cad1f19cf4d',
    armv7l: '7b87e31690157dc58eb495a8e6daf2f334866a8f5aa0dda171cb6cad1f19cf4d',
      i686: 'c34abd516d109070b2c57976f5cb7821b67fe65d5dcd1a010b3e3f3d31f94178'
  })

  depends_on 're2c' => :build
  depends_on 'emacs' => :build

  def self.patch
    system 'filefix'
  end

  def self.build
    system 'python3 configure.py --bootstrap'
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
