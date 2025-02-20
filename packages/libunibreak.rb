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
    aarch64: '8ef735b3e2d32847bec5f5efeb4262fc13b3fea13675413b788be9eda6982368',
     armv7l: '8ef735b3e2d32847bec5f5efeb4262fc13b3fea13675413b788be9eda6982368',
       i686: '4117eedf5a1ce99d64c232c557ea08761caff4efaf43e910e47a5efe1f3874e7',
     x86_64: 'ec19ac9a29328534d8f32bd4d88b4cb11c5bea9e72f9623e46fafb4221097f11'
  })

  depends_on 'glibc' # R
end
