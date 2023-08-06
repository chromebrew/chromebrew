require 'buildsystems/cmake'

class Remmina < CMake
  description 'The GTK Remmina Remote Desktop Client'
  homepage 'https://remmina.org/'
  version '1.4.31'
  license 'GPL-2+-with-openssl-exception'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://gitlab.com/Remmina/Remmina/-/archive/v#{version}/Remmina-v#{version}.tar.bz2"
  source_sha256 'cfe9d4a6f2951d35533e5b2235f76640573c91f1be3bd8118637fbf68234500a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/remmina/1.4.31_armv7l/remmina-1.4.31-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/remmina/1.4.31_armv7l/remmina-1.4.31-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/remmina/1.4.31_x86_64/remmina-1.4.31-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '13bab15460150e329feb3fbbd4ac68db26e599871f027d6467674d82d09304f6',
     armv7l: '13bab15460150e329feb3fbbd4ac68db26e599871f027d6467674d82d09304f6',
     x86_64: 'b23f93b472e5e8dbaa021bb920bd63fc5df9c0d5e0282b2b1b0b6d1fd4d3a467'
  })

  depends_on 'avahi' # L
  depends_on 'cairo' # R
  depends_on 'cups' # R
  depends_on 'freerdp' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'json_glib' # R
  depends_on 'libappindicator_gtk3' # R
  depends_on 'libgcrypt' # R
  depends_on 'libsecret' # R
  depends_on 'libsodium' # R
  depends_on 'libsoup' # R
  depends_on 'libssh' # R
  depends_on 'libvncserver' # R
  depends_on 'openssl' # R
  depends_on 'pango' # R
  depends_on 'python3' # R
  depends_on 'sommelier' # L
  depends_on 'spice_gtk' => :build
  depends_on 'vte' # R
  depends_on 'wayland' # R
  depends_on 'webkit2gtk_4_1' # R
  depends_on 'xdg_utils' => :build
  depends_on 'xprop' # L

  cmake_options << '-DCMAKE_SKIP_INSTALL_RPATH=ON \
      -DWITH_TELEPATHY=OFF'
end
