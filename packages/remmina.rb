require 'buildsystems/cmake'

class Remmina < CMake
  description 'The GTK Remmina Remote Desktop Client'
  homepage 'https://remmina.org/'
  version '1.4.43'
  license 'GPL-2+-with-openssl-exception'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.com/Remmina/Remmina.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c5896cc47036d2bf7e2904d1826ad6501ba55e22dfa09d080f6d6b035383361',
     armv7l: '0c5896cc47036d2bf7e2904d1826ad6501ba55e22dfa09d080f6d6b035383361',
     x86_64: 'b814a4b745e2557720f1489c913ac15f7b9a544ea4d4b32c774ef7a690152081'
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
