require 'buildsystems/meson'

class Jsoncpp < Meson
  description 'A C++ library for interacting with JSON.'
  homepage 'https://github.com/open-source-parsers/jsoncpp'
  version '1.9.7'
  license 'MIT, public-domain'
  compatibility 'all'
  source_url 'https://github.com/open-source-parsers/jsoncpp.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '768995f3ef460d128f25affb65e0a3de8dd866aadacd998c551485992b2dccf6',
     armv7l: '768995f3ef460d128f25affb65e0a3de8dd866aadacd998c551485992b2dccf6',
       i686: 'f5b27c142a07ec5ae2e4b8030feb9f12997341eb662479c0a049e3b67da69193',
     x86_64: '4a1e67172ddcf3d6531a7fd387685c30c3c64440ae82eb03b2f06d2b9eeea344'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
end
