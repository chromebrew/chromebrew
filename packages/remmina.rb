require 'buildsystems/cmake'

class Remmina < CMake
  description 'The GTK Remmina Remote Desktop Client'
  homepage 'https://remmina.org/'
  version '1.4.42'
  license 'GPL-2+-with-openssl-exception'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.com/Remmina/Remmina.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '089357a8c3c6fc5b833f200df85a016af9a552874ec8dd6447f776c6d4dcaf04',
     armv7l: '089357a8c3c6fc5b833f200df85a016af9a552874ec8dd6447f776c6d4dcaf04',
     x86_64: '481a80de2bfd73f8ad9e75c0a174dcc13ba662e556df05ba63f7ec9c5b5e7cf2'
  })

  depends_on 'avahi' # L
  depends_on 'cairo' # R
  depends_on 'cups' # R
  depends_on 'curl' => :executable_only
  depends_on 'freerdp' # R
  depends_on 'fuse3' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'json_glib' => :executable_only
  depends_on 'libappindicator_gtk3' => :executable_only
  depends_on 'libgcrypt' => :executable_only
  depends_on 'libsecret' # R
  depends_on 'libsodium' => :executable_only
  depends_on 'libsoup' # R
  depends_on 'libssh' => :executable_only
  depends_on 'libvncserver' # R
  depends_on 'openssl' => :executable_only
  depends_on 'pango' # R
  depends_on 'python3' # R
  depends_on 'sommelier' => :logical
  depends_on 'spice_gtk' => :build
  depends_on 'vte' => :executable_only
  depends_on 'wayland' # R
  depends_on 'webkit2gtk_4_1' # R
  depends_on 'xdg_utils' => :build
  depends_on 'xprop' # L

  cmake_options '-DCMAKE_SKIP_INSTALL_RPATH=ON \
      -DWITH_FREERDP3:BOOL=ON \
      -DWITH_TELEPATHY=OFF'
end
