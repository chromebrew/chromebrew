require 'buildsystems/autotools'

class Tmux < Autotools
  description 'tmux is a terminal multiplexer'
  homepage 'https://tmux.github.io/'
  version '3.7c'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/tmux/tmux.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fdf5426a21ec8938f1288e4d27b3a024c9d0397a9d7ceeac6ff2366ca7946185',
     armv7l: 'fdf5426a21ec8938f1288e4d27b3a024c9d0397a9d7ceeac6ff2366ca7946185',
       i686: 'e7dfe9f20c49f882b1bc5daf461c655fce0bf1de79e842a05ee61b0b659d372d',
     x86_64: '0be31cfb22e0523a9c9040bd2d52de439c190c626ebc167664235de0d2762b6b'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libevent' => :executable
  depends_on 'ncurses' => :executable
end
