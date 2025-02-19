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
       i686: '4117eedf5a1ce99d64c232c557ea08761caff4efaf43e910e47a5efe1f3874e7',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'glibc' # R
end
