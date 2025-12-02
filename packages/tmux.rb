require 'buildsystems/autotools'

class Tmux < Autotools
  description 'tmux is a terminal multiplexer'
  homepage 'https://tmux.github.io/'
  version '3.6'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/tmux/tmux.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e8ef8141b84d05658b85c9a23e0c81f63ee90f9e755b7f68c15aebb5636b9be3',
     armv7l: 'e8ef8141b84d05658b85c9a23e0c81f63ee90f9e755b7f68c15aebb5636b9be3',
       i686: '0ac5848183706b175b40b33c9f3ffe51414f59b1dfc1a13b798752d710583510',
     x86_64: '3f668409f0eab1ede9528edea34dbf5f4df62bd3247342d1e451f523b33790fa'
  })

  depends_on 'glibc' # R
  depends_on 'libevent' # R
  depends_on 'ncurses' # R
end
