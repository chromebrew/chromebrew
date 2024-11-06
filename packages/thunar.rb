require 'buildsystems/autotools'

class Thunar < Autotools
  description 'Thunar File Manager'
  homepage 'https://docs.xfce.org/xfce/thunar/Start'
  version '4.19.3'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://archive.xfce.org/src/xfce/thunar/#{version.rpartition('.')[0]}/thunar-#{version}.tar.bz2"
  source_sha256 '9a7876352e8a54dd5a52c64affb54e7c8582e64dd569d9fe43af5835d9485b37'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9c0b8d344e3bc98aabd00a82b610fab3770c9012ceafc8891fb59fed239da7fa',
     armv7l: '9c0b8d344e3bc98aabd00a82b610fab3770c9012ceafc8891fb59fed239da7fa',
     x86_64: 'fed5d6d825cd3184d85eb831000cb98124e61a53d7c51ee6ffe074b07cca9d39'
  })

  depends_on 'exo'
  depends_on 'libexif'
  depends_on 'libgudev'
  depends_on 'libnotify'
  depends_on 'xfce4_panel'
  depends_on 'desktop_file_utilities'
  depends_on 'hicolor_icon_theme'
  depends_on 'xdg_base'
  depends_on 'wayland'

  configure_options '--enable-gio-unix \
    --enable-gudev \
    --enable-exif \
    --enable-pcre \
    --disable-static \
    --enable-notifications'

  run_tests
end
