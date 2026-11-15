require 'buildsystems/autotools'

class Recordmydesktop < Autotools
  description 'desktop session recorder for GNU / Linux that attempts to be easy to use'
  homepage 'https://recordmydesktop.sourceforge.net/about.php'
  version '0.4.0'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/Enselic/recordmydesktop.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '906d1896e18f9c24f593e93bbff2dc44770e909a8a8c876fa9ded8c301b188cf',
     armv7l: '906d1896e18f9c24f593e93bbff2dc44770e909a8a8c876fa9ded8c301b188cf',
     x86_64: '8896579cb5b2212c96e3728e29f7a4a827021f1294b2b52c40139d0194488efc'
  })

  depends_on 'alsa_lib' => :executable
  depends_on 'alsa_plugins' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'jack' => :executable
  depends_on 'libice' => :executable
  depends_on 'libogg' => :executable
  depends_on 'libsm' => :executable
  depends_on 'libtheora' => :executable
  depends_on 'libvorbis' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxdamage' => :executable
  depends_on 'libxext' => :executable
  depends_on 'libxfixes' => :executable
  depends_on 'popt' => :executable
  depends_on 'sommelier' => :logical
  depends_on 'zlib' => :executable

  autotools_build_relative_dir 'recordmydesktop'
end
