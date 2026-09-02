require 'buildsystems/autotools'

class Zvbi < Autotools
  description 'VBI capture and decoding library.'
  homepage 'https://github.com/zapping-vbi/zvbi'
  version '0.2.45'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/zapping-vbi/zvbi.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fbf3013bca7f19416d6bd897bb2160ff7800aa55942f3dcda716dd9b3130359a',
     armv7l: 'fbf3013bca7f19416d6bd897bb2160ff7800aa55942f3dcda716dd9b3130359a',
     x86_64: '89c7a3244515259b3ccc016bd568054e43b1d35b6a7c7a8cfa644772faae0f7d'
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
