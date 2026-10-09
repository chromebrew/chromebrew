require 'buildsystems/autotools'

class Tmux < Autotools
  description 'tmux is a terminal multiplexer'
  homepage 'https://tmux.github.io/'
  version '3.8'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/tmux/tmux.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1c6915a78ce6ae7f4e57b97cb229e845faab733e6fefcf2900acd1be9c28ab12',
     armv7l: '1c6915a78ce6ae7f4e57b97cb229e845faab733e6fefcf2900acd1be9c28ab12',
       i686: '2e8fecfd56e1d887ea53a9b247b8ee12bd085a2cc8337cd7f3ef275e699a9043',
     x86_64: '383ff27c52798fab669c49ab0578bf9edaf22b2bd171840de4a96aa5d2882d11'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libevent' => :executable
  depends_on 'ncurses' => :executable
end
