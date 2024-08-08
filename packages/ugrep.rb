require 'buildsystems/autotools'

class Ugrep < Autotools
  description 'A more powerful, ultra fast, user-friendly, compatible grep'
  homepage 'https://ugrep.com/'
  version '6.4.0'
  license 'BSD-3 Clause'
  compatibility 'x86_64'
  source_url 'https://github.com/Genivia/ugrep.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    x86_64: 'e508afd341a256673af950aa63fe6e1a87658d511161aef1122f4841e4c7a789'
  })

  depends_on 'brotli'
  depends_on 'bzip2'
  depends_on 'lz4'
  depends_on 'pcre2'
  depends_on 'xzutils'
  depends_on 'zlib'
  depends_on 'zstd'
end
