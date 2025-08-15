require 'buildsystems/autotools'

class Zimg < Autotools
  description 'Scaling, colorspace conversion, and dithering library'
  homepage 'https://github.com/sekrit-twc/zimg'
  version '3.0.6'
  license 'WTFPL-2'
  compatibility 'all'
  source_url 'https://github.com/sekrit-twc/zimg.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '661533557540a229d13509748d50659e94cfd18b372826f99a10a0c939045938',
     armv7l: '661533557540a229d13509748d50659e94cfd18b372826f99a10a0c939045938',
       i686: '540c06559d4af3a1eedbc10d4e660d6a1b123a1062ab3c57f58da79a0b96fb5f',
     x86_64: 'b84d0eee8ecb1b8a3e7c502a7fae47a663dbabbf4709a4515013303d9984be7b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
