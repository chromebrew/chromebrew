require 'buildsystems/autotools'

class Libunibreak < Autotools
  description 'Unicode line-breaking library'
  homepage 'https://github.com/adah1972/libunibreak'
  version '6.1'
  license 'zlib'
  compatibility 'all'
  source_url 'https://github.com/adah1972/libunibreak.git'
  git_hashtag "libunibreak_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })
end
