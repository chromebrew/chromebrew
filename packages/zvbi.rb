require 'buildsystems/autotools'

class Zvbi < Autotools
  description 'VBI capture and decoding library.'
  homepage 'https://github.com/zapping-vbi/zvbi'
  version '0.2.46'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/zapping-vbi/zvbi.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c67b19fd50f1dc891c2bb3b5cdda738be88351ffedfda4023a7a4d54898ffe1f',
     armv7l: 'c67b19fd50f1dc891c2bb3b5cdda738be88351ffedfda4023a7a4d54898ffe1f',
     x86_64: 'd4088232461d81245fc38354c58b08d17f63c294d0ff243cc2bd92a98230664a'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libbsd' => :executable
  depends_on 'libmd' => :library
  depends_on 'libpng' => :library
  depends_on 'libx11' => :executable
  depends_on 'libxau' => :executable
  depends_on 'libxcb' => :executable
  depends_on 'libxdmcp' => :executable
  depends_on 'zlib' => :library
end
