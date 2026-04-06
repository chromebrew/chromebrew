require 'buildsystems/perl'

class Alien < PERL
  description 'This program converts Linux packages between the rpm, deb, tgz and slp packages.'
  homepage 'https://sourceforge.net/projects/alien-pkg-convert/'
  version '8.95.9'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/Project-OSS-Revival/alien.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ea65282e62f9b5817c40ee89ed7acc9bc81153a05e3a8f3fd21f490a0a06bb99',
     armv7l: 'ea65282e62f9b5817c40ee89ed7acc9bc81153a05e3a8f3fd21f490a0a06bb99',
       i686: 'c9b8bb2bf420c7b32306c28f0b3a51c457794f41f1b462b923634e7068853a4a',
     x86_64: 'a5d99661630a80f99e3dbd6cce40dc6b683ef7e178afa36bf09b8a0207066835'
  })

  depends_on 'perl' => :logical
end
