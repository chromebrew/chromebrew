require 'buildsystems/meson'

class Libxfixes < Meson
  description 'library for the X window system'
  homepage 'https://x.org/wiki/'
  version '6.0.2'
  license 'custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxfixes.git'
  git_hashtag "libXfixes-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '334ba4a7dc7f8578bcc687dead94717e95793cf672e2c081c43b4e2707ef0251',
     armv7l: '334ba4a7dc7f8578bcc687dead94717e95793cf672e2c081c43b4e2707ef0251',
     x86_64: 'f6d7949392afb2defb0231a28011ecac138d8f3dd744bd2f2c2fcc27e5bcb2a4'
  })

  depends_on 'libx11' # R
  depends_on 'glibc' # R
end
