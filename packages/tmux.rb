require 'buildsystems/autotools'

class Tmux < Autotools
  description 'tmux is a terminal multiplexer'
  homepage 'https://tmux.github.io/'
  version '3.6b'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/tmux/tmux.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ac83f2acbce44951a081cab278b3ebc8c80596b3f9bc713d53548f4c8a2e77af',
     armv7l: 'ac83f2acbce44951a081cab278b3ebc8c80596b3f9bc713d53548f4c8a2e77af',
       i686: '181d7d2e673f24b26b2fc47f46f998362661e3574a98a268f8149d245691409a',
     x86_64: '86d3aeaf0dae615c46ba3310b89abd020abfb8cfb58df56d0348a20fee2dfe3a'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libevent' => :executable
  depends_on 'ncurses' => :executable
end
