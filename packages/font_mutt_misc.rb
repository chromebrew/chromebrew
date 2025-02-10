require 'buildsystems/autotools'

class Font_mutt_misc < Autotools
  description '100dpi PCF versions of the ClearlyU fonts'
  homepage 'https://gitlab.freedesktop.org/xorg/font/mutt-misc'
  version '1.0.4'
  license 'custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/font/mutt-misc.git'
  git_hashtag "font-mutt-misc-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'be5e31d4e84b6dc098327963f8175d71a3e2ee90eb67bbfe5b5b70ddb2e80338',
     armv7l: 'be5e31d4e84b6dc098327963f8175d71a3e2ee90eb67bbfe5b5b70ddb2e80338',
     x86_64: '9b0a25a23a9ed9e5007c32c0693982d9446f5213b5888b0967bdb20457a9a4a9'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'
  depends_on 'xorg_macros' => :build
end
