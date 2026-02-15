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
    aarch64: '886ad73155ec81b311b4762922085f3b88619f4c65f1943d3e8d9e8521d3fc5e',
     armv7l: '886ad73155ec81b311b4762922085f3b88619f4c65f1943d3e8d9e8521d3fc5e',
     x86_64: '10b9d3006e9b2dda400c4d8c0a84638fb1d3dff1188f3e6896f63c4a7ef9dea2'
  })

  depends_on 'avahi' # L
  depends_on 'cairo' # R
  depends_on 'cups' # R
  depends_on 'curl' # R
  depends_on 'freerdp' # R
  depends_on 'fuse3' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
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
  depends_on 'sommelier' => :logical
  depends_on 'spice_gtk' => :build
  depends_on 'vte' # R
  depends_on 'wayland' # R
  depends_on 'webkit2gtk_4_1' # R
  depends_on 'xdg_utils' => :build
  depends_on 'xprop' # L

  cmake_options '-DCMAKE_SKIP_INSTALL_RPATH=ON \
      -DWITH_FREERDP3:BOOL=ON \
      -DWITH_TELEPATHY=OFF'
end
