require 'buildsystems/autotools'

class Tmux < Autotools
  description 'tmux is a terminal multiplexer'
  homepage 'https://tmux.github.io/'
  version '3.7b'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/tmux/tmux.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '832cb24d8af959bde24f080b1d4d2b1d9e170682e97f47da2dea2eae064a2e3b',
     armv7l: '832cb24d8af959bde24f080b1d4d2b1d9e170682e97f47da2dea2eae064a2e3b',
       i686: 'f2e9c80b77d1434a3d51846786b0f71a84d550b972e84c2f656145020b55cd7a',
     x86_64: '234c945b3327c9b92376c27a065229834607a8a1b3695e0ddbf9f1ed047940bb'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libevent' => :executable
  depends_on 'ncurses' => :executable
end
