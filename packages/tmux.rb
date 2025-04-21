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
       i686: 'e7c110ed9a390bfb963d6ed70c50f6a0039823fd802ab4aa425a9d831f0d9271',
     x86_64: '3856197ff401420c0cf0a62c47d5e1c3f44f5056e3f46848c6b6963fc9ed2538'
  })

  depends_on 'glibc' # R
  depends_on 'libevent' # R
  depends_on 'ncurses' # R
end
