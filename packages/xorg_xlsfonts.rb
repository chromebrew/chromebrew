# Adapted from Arch Linux xorg-xlsfonts PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/xorg-xlsfonts/trunk/PKGBUILD

require 'buildsystems/autotools'

class Xorg_xlsfonts < Autotools
  description 'List available X fonts'
  homepage 'https://xorg.freedesktop.org/wiki/'
  version '1.0.9'
  license 'X11'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xlsfonts.git'
  git_hashtag "xlsfonts-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5ebf9093ea1ef6d4f329a49166fe78901edf154304d7b09fcca04ea922b9b64a',
     armv7l: '5ebf9093ea1ef6d4f329a49166fe78901edf154304d7b09fcca04ea922b9b64a',
     x86_64: '31c4d001c7ae648e606c3dcd4000617dec5ac0c21515b14fc752082473117d83'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libx11' => :executable
  depends_on 'xorg_macros' => ':build'
end
