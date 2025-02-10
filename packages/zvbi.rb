require 'buildsystems/autotools'

class Zvbi < Autotools
  description 'VBI capture and decoding library.'
  homepage 'https://github.com/zapping-vbi/zvbi'
  version '0.2.42-be5efeb'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/zapping-vbi/zvbi.git'
  git_hashtag 'be5efebaadeb95be57d5435468bd3ec0f3007683'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd2f582b4ee393dc0eca53805098b354efc68a766a32b2277fad26033a4bc1258',
     armv7l: 'd2f582b4ee393dc0eca53805098b354efc68a766a32b2277fad26033a4bc1258',
     x86_64: '622a92ff1bb9711422ba33d37a7635245adc0c1ba5f60cfb7a3aa7b150956682'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libpng' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'zlib' # R
end
