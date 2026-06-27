require 'buildsystems/autotools'

class Tmux < Autotools
  description 'tmux is a terminal multiplexer'
  homepage 'https://tmux.github.io/'
  version '3.7'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/tmux/tmux.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b12bbbbad20bafa96392e1a6477da3d3b7ff26761cc073b715c6c9d352521b84',
     armv7l: 'b12bbbbad20bafa96392e1a6477da3d3b7ff26761cc073b715c6c9d352521b84',
       i686: '0007a1982e726d6bf486b5e598e000c5964f438b2f3bd18d6e25f3027091e6ca',
     x86_64: '6fc679db4c279f0a7f4fc9fc0d0a13c6975ecb9cca9cb4f1d7006aa12a982a79'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libevent' => :executable
  depends_on 'ncurses' => :executable
end
