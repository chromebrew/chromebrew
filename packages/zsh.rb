require 'package'

class Zsh < Package
  description 'Zsh is a shell designed for interactive use, although it is also a powerful scripting language.'
  homepage 'http://zsh.sourceforge.net/'
  version '5.8.1-1'
  license 'ZSH and GPL-2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/zsh/zsh/5.8.1/zsh-5.8.1.tar.xz'
  source_sha256 'b6973520bace600b4779200269b1e5d79e5f505ac4952058c11ad5bbf0dd9919'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zsh/5.8.1-1_armv7l/zsh-5.8.1-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zsh/5.8.1-1_armv7l/zsh-5.8.1-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zsh/5.8.1-1_i686/zsh-5.8.1-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zsh/5.8.1-1_x86_64/zsh-5.8.1-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e2823b5b07a21ead7390305256fd04328f07d9f536bbf3bc0d77da54f9ace214',
     armv7l: 'e2823b5b07a21ead7390305256fd04328f07d9f536bbf3bc0d77da54f9ace214',
       i686: 'af70de10fa62dd86541934214a2addcbd20ae1a776b466bc90ad8f4e5b19cfbc',
     x86_64: '1cf958108388929dc8743c85b095e17e4794407037ab058d579648593fdb425b'
  })

  depends_on 'gdbm' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'gcc' # R
  patchelf

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
