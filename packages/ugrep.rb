require 'buildsystems/autotools'

class Ugrep < Autotools
  description 'A more powerful, ultra fast, user-friendly, compatible grep'
  homepage 'https://ugrep.com/'
  version '6.1.0'
  license 'BSD-3 Clause'
  compatibility 'x86_64'
  source_url 'https://github.com/Genivia/ugrep.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    x86_64: '4d340a5955c869d6082c49b4d2605ec83a27364f68bcadacdce68f4f1931d299'
  })

  depends_on 'brotli'
  depends_on 'bzip2'
  depends_on 'lz4'
  depends_on 'pcre2'
  depends_on 'xzutils'
  depends_on 'zlibpkg'
  depends_on 'zstd'
end
