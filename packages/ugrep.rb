require 'buildsystems/autotools'

class Ugrep < Autotools
  description 'A more powerful, ultra fast, user-friendly, compatible grep'
  homepage 'https://ugrep.com/'
  version '4.3.6'
  license 'BSD-3 Clause'
  compatibility 'x86_64'
  source_url 'https://github.com/Genivia/ugrep.git'
  git_hashtag "v#{version}"

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ugrep/4.3.6_x86_64/ugrep-4.3.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '330e1c844db6af3182c4532f4cfcfc045221159fe247959c240cc397e25ca74c'
  })

  depends_on 'brotli'
  depends_on 'bzip2'
  depends_on 'lz4'
  depends_on 'pcre2'
  depends_on 'xzutils'
  depends_on 'zlibpkg'
  depends_on 'zstd'
end
