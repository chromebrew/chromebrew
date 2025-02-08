require 'buildsystems/autotools'

class Liba52 < Autotools
  description 'liba52 is a free library for decoding ATSC A/52 streams.'
  homepage 'https://sourceforge.net/projects/liba52/'
  version '0.8.0'
  compatibility 'all'
  license 'GPL-2+'
  source_url 'https://git.adelielinux.org/community/a52dec.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a16c0ecfbf1b48be822e3957ef8b8de277cef06b034603bf1bc122f2922c7823',
     armv7l: 'a16c0ecfbf1b48be822e3957ef8b8de277cef06b034603bf1bc122f2922c7823',
       i686: '51c100dddd25d3befa5cbafc291b1900f855eb4e41017e4024ca861b1d762e33',
     x86_64: '541e8d510e4b517df2aecd46d835f92c7ca223c171f227a89b443254aab66b33'
  })

  run_tests
end
