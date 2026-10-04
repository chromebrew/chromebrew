require 'buildsystems/autotools'

class Passt < Autotools
  description 'Plug A Simple Socket Transport'
  homepage 'https://passt.top/passt/about/'
  version '2026_10_02.cba3570'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://passt.top/passt'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7a0ef7a8c9f945f02ff5b4a8c109292a8cea81b8892b034412d9aed49d694b19',
     armv7l: '7a0ef7a8c9f945f02ff5b4a8c109292a8cea81b8892b034412d9aed49d694b19',
     x86_64: '0668248d2f879051892d7d0f5979ffbaf24612c2dadded89c40327d134cdf76a'
  })

  autotools_skip_configure
end
