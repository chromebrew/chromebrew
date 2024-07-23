require 'buildsystems/autotools'

class Rpcsvc_proto < Autotools
  description 'rpcsvc protocol definitions from glibc'
  homepage 'https://github.com/thkukuk/rpcsvc-proto'
  version '1.4.4'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/thkukuk/rpcsvc-proto.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6df631b717d3da06be71951de63a13f9b23b45e1941fdee2debd4987d0c57f2b',
     armv7l: '6df631b717d3da06be71951de63a13f9b23b45e1941fdee2debd4987d0c57f2b',
       i686: 'bcc9dd7be42858dbc5fe0de2eb6d6e83dd6422e87dfdaa3f2d6f3493f6eda3c9',
     x86_64: 'b4bd2ddd9fc77695b6e00ed433a0e9d149792b113ad057ed1bdf4271525d689a'
  })
end
