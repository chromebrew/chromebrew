# Adapted from Arch Linux sysprof PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/sysprof/trunk/PKGBUILD

require 'buildsystems/meson'

class Sysprof < Meson
  description 'Kernel based performance profiler'
  homepage 'https://wiki.gnome.org/Apps/Sysprof'
  version '49.0'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/sysprof.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a88e6edd2a5f915db48c885de3c5e0e79f1017afaf6b05b88e82b5c4dddbf38a',
     armv7l: 'a88e6edd2a5f915db48c885de3c5e0e79f1017afaf6b05b88e82b5c4dddbf38a',
     x86_64: 'f7b49506364fda0c83492156182a901b0cad722e94cff0c40bd18c9acc57d9fe'
  })

  depends_on 'cairo' # R
  depends_on 'desktop_file_utils' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'graphene' # R
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'json_glib' # R
  depends_on 'libadwaita' # R
  depends_on 'libdex' # R
  depends_on 'libpanel' # R
  depends_on 'libunwind' # R
  depends_on 'pango' # R
  depends_on 'polkit' # R

  meson_options '-Dsysprofd=none \
                 -Dexamples=false \
                 -Dhelp=false \
                 -Dtests=false \
                 -Dtools=false'
end
