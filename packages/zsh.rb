require 'package'

class Zsh < Package
  description 'Zsh is a shell designed for interactive use, although it is also a powerful scripting language.'
  homepage 'http://zsh.sourceforge.net/'
  version '5.8.1'
  license 'ZSH and GPL-2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/zsh/zsh/5.8.1/zsh-5.8.1.tar.xz'
  source_sha256 'b6973520bace600b4779200269b1e5d79e5f505ac4952058c11ad5bbf0dd9919'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zsh/5.8.1_armv7l/zsh-5.8.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zsh/5.8.1_armv7l/zsh-5.8.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zsh/5.8.1_i686/zsh-5.8.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zsh/5.8.1_x86_64/zsh-5.8.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '66be508e6f844d36f2d173965b253231204f206d95785fe74a1c8e4280217126',
     armv7l: '66be508e6f844d36f2d173965b253231204f206d95785fe74a1c8e4280217126',
       i686: '579921c5ea4c7c66254f63b061463dcd2bcc32bc77a6ff5278c6a54f0d4e0777',
     x86_64: 'c8c3e4cb8ec2a85684a134de076ed5dd8bf4dc36a067d03d68aba0073eacfe36'
  })

  depends_on 'gdbm' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'gcc' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
