require 'buildsystems/cmake'

class Remmina < CMake
  description 'The GTK Remmina Remote Desktop Client'
  homepage 'https://remmina.org/'
  version '1.4.40'
  license 'GPL-2+-with-openssl-exception'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.com/Remmina/Remmina.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fd0c2b9110b8e99079d1f8ff8410f1592910176ff34698fa6c6d8b6793449b9d',
     armv7l: 'fd0c2b9110b8e99079d1f8ff8410f1592910176ff34698fa6c6d8b6793449b9d',
     x86_64: 'b57ff80f3291548ac50093510d86584f7f92c28649b1dfaac724114d7f1e192f'
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
