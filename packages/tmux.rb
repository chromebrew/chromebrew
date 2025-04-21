require 'buildsystems/autotools'

class Tmux < Autotools
  description 'tmux is a terminal multiplexer'
  homepage 'https://tmux.github.io/'
  version '3.5a'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/tmux/tmux.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ee0d154b58e740eb8c518b24d0b5757ed5d1589fed73073445ae1081b948f6ca',
     armv7l: 'ee0d154b58e740eb8c518b24d0b5757ed5d1589fed73073445ae1081b948f6ca',
       i686: '6673270a601898dba1c6b78fff93d0283afa78f710b81535515dfdc1cf4ce856',
     x86_64: '60af8db11c350e5db56ef68d6cc976c479de0b45ad455fd4129698efa7e9e785'
  })

  depends_on 'glibc' # R
  depends_on 'libevent' # R
  depends_on 'ncurses' # R
end
