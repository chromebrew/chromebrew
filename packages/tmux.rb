require 'buildsystems/autotools'

class Tmux < Autotools
  description 'tmux is a terminal multiplexer'
  homepage 'https://tmux.github.io/'
  version '3.6a'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/tmux/tmux.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '90b0ed451743c1bfb6a891042d56a85ddfe6f430a3c6510a771081dafaf2012d',
     armv7l: '90b0ed451743c1bfb6a891042d56a85ddfe6f430a3c6510a771081dafaf2012d',
       i686: '9ccb995cf5437c44cd6c46c24aef618e3e473d95d593e3c6659f44a56f4e7c97',
     x86_64: 'e220309f4a78a9cd028861d3e7341087cbb4c09f401177adfccc643201d45594'
  })

  depends_on 'glibc' => :executable
  depends_on 'libevent' => :executable
  depends_on 'ncurses' => :executable
end
