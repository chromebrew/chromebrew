require 'buildsystems/autotools'

class Ugrep < Autotools
  description 'A more powerful, ultra fast, user-friendly, compatible grep'
  homepage 'https://ugrep.com/'
  version '4.4.1'
  license 'BSD-3 Clause'
  compatibility 'x86_64'
  source_url 'https://github.com/Genivia/ugrep.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ugrep/4.4.1_x86_64/ugrep-4.4.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '13bf9916809ac1537f7bdc1021f86bf881cc62f4dc29bcce33efb202df177c76'
  })

  depends_on 'brotli'
  depends_on 'bzip2'
  depends_on 'lz4'
  depends_on 'pcre2'
  depends_on 'xzutils'
  depends_on 'zlibpkg'
  depends_on 'zstd'
end
