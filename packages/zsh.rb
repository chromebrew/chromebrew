require 'buildsystems/autotools'

class Zsh < Autotools
  description 'Zsh is a shell designed for interactive use, although it is also a powerful scripting language.'
  homepage 'https://zsh.sourceforge.io/'
  version '5.9.2'
  license 'ZSH and GPL-2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/zsh/zsh/#{version}/zsh-#{version}.tar.xz"
  source_sha256 '36fa734374b44783582cec09bcd67822e2f992c779ec1624ab5596df078d2f81'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7758a2c5c8c6edc3c78ae334bdf416b7b0d84b5bb6683b56bec206f0c0ba8d8d',
     armv7l: '7758a2c5c8c6edc3c78ae334bdf416b7b0d84b5bb6683b56bec206f0c0ba8d8d',
       i686: '2ff55f857f7443e133b789c9755fa4e302893333f1b17fd67fe47354c0d4d874',
     x86_64: '6510b27762d5d3138bbbca19aa537bbbd7c7d35d0fa3dbc8794fbd6760e267bd'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'gdbm' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libcap' => :library
  depends_on 'ncurses' => :library
  depends_on 'pcre' => :library
  depends_on 'pcre2' => :library

  autotools_configure_options ' \
    --enable-zsh-mem \
    --enable-pcre \
    --enable-cap \
    --enable-gdbm \
    --enable-multibyte'
end
