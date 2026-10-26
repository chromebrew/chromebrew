require 'buildsystems/meson'

class Libxfce4windowing < Meson
  description 'Windowing concept abstraction library for X11 and Wayland'
  homepage 'https://docs.xfce.org/xfce/libxfce4windowing/start'
  version '4.20.7'
  license 'LGPLv2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.xfce.org/xfce/libxfce4windowing.git'
  git_hashtag "libxfce4windowing-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f4142c95a7a298bc0786c7632f92f532b0b6b74c4032d9c7ed9c1844a33c89da',
     armv7l: 'f4142c95a7a298bc0786c7632f92f532b0b6b74c4032d9c7ed9c1844a33c89da',
     x86_64: '8d00a5ca6ed2feb13422ef026f001bf2f1c13da9fd8ef78e35a404e8d98d69ee'
  })

  depends_on 'cairo' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gtk3' => :library
  depends_on 'libdisplay_info' => :library
  depends_on 'libwnck' => :library
  depends_on 'libx11' => :library
  depends_on 'libxrandr' => :library
  depends_on 'pango' => :library
  depends_on 'wayland' => :library
  depends_on 'weston' => :library
  depends_on 'wlr_protocols' => :library
end
