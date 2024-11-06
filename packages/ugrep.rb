require 'buildsystems/autotools'

class Ugrep < Autotools
  description 'A more powerful, ultra fast, user-friendly, compatible grep'
  homepage 'https://ugrep.com/'
  version '6.4.1'
  license 'BSD-3 Clause'
  compatibility 'x86_64'
  source_url 'https://github.com/Genivia/ugrep.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '3991c589dd48cd5afe89726da8d677a8b5c0cb64e7f3e2883714fd5b778b9e7c'
  })

  depends_on 'brotli'
  depends_on 'bzip2'
  depends_on 'lz4'
  depends_on 'pcre2'
  depends_on 'xzutils'
  depends_on 'zlib'
  depends_on 'zstd'
end
