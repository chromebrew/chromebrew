require 'buildsystems/cmake'

class Remmina < CMake
  description 'The GTK Remmina Remote Desktop Client'
  homepage 'https://remmina.org/'
  version '1.4.39'
  license 'GPL-2+-with-openssl-exception'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://gitlab.com/Remmina/Remmina/-/archive/v#{version}/Remmina-v#{version}.tar.bz2"
  source_sha256 '6ce8944e87f5a7bb5c96587a9d8df412f852717f49e58a7289dd24175519fe46'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4a5e869bf74adc0a449f88e4bc6d71c9a1ac2915045cb0f80ef243a6b6ee08df',
     armv7l: '4a5e869bf74adc0a449f88e4bc6d71c9a1ac2915045cb0f80ef243a6b6ee08df',
     x86_64: '69f0f6a0c131925a580d69def851594c6629807b38233f56efff6cdf715f7ec8'
  })

  depends_on 'avahi' # L
  depends_on 'cairo' # R
  depends_on 'cups' # R
  depends_on 'curl' # R
  depends_on 'freerdp' # R
  depends_on 'fuse3' # R
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

  cmake_options '-DCMAKE_SKIP_INSTALL_RPATH=ON \
      -DWITH_FREERDP3:BOOL=ON \
      -DWITH_TELEPATHY=OFF'
end
