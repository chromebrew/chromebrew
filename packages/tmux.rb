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
    aarch64: '6ac7265cc2ffb5fa257b1a815845a12cb80012d07606201cc9da8132f1fb86d4',
     armv7l: '6ac7265cc2ffb5fa257b1a815845a12cb80012d07606201cc9da8132f1fb86d4',
       i686: '6673270a601898dba1c6b78fff93d0283afa78f710b81535515dfdc1cf4ce856',
     x86_64: '60af8db11c350e5db56ef68d6cc976c479de0b45ad455fd4129698efa7e9e785'
  })

  depends_on 'glibc' # R
  depends_on 'libevent' # R
  depends_on 'ncurses' # R
end
