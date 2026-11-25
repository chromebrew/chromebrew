require 'buildsystems/cmake'

class Remmina < CMake
  description 'The GTK Remmina Remote Desktop Client'
  homepage 'https://remmina.org/'
  version '1.4.44'
  license 'GPL-2+-with-openssl-exception'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.com/Remmina/Remmina.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '362c4763517a144de61dbf9825ff32379d20fa586776ad1d653a0e8046e783a1',
     armv7l: '362c4763517a144de61dbf9825ff32379d20fa586776ad1d653a0e8046e783a1',
     x86_64: '3bf7e005658f90baf3eb2fb6b1501023623888f463899a85e87c74716ac704c1'
  })

  depends_on 'avahi' => :logical
  depends_on 'cairo' => :library
  depends_on 'cups' => :library
  depends_on 'curl' => :executable
  depends_on 'freerdp' => :library
  depends_on 'fuse3' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' # R
  depends_on 'json_glib' => :executable
  depends_on 'libappindicator_gtk3' => :executable
  depends_on 'libgcrypt' => :executable
  depends_on 'libsecret' => :library
  depends_on 'libsodium' => :executable
  depends_on 'libsoup' => :library
  depends_on 'libssh' => :executable
  depends_on 'libvncserver' => :library
  depends_on 'openssl' => :executable
  depends_on 'pango' => :library
  depends_on 'python3' => :library
  depends_on 'sommelier' => :logical
  depends_on 'spice_gtk' => :build
  depends_on 'vte' => :executable
  depends_on 'wayland' => :library
  depends_on 'webkit2gtk_4_1' => :library
  depends_on 'xdg_utils' => :build
  depends_on 'xprop' => :logical

  cmake_options '-DCMAKE_SKIP_INSTALL_RPATH=ON \
      -DWITH_FREERDP3:BOOL=ON \
      -DWITH_TELEPATHY=OFF'
end
