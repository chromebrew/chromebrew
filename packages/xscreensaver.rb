require 'buildsystems/autotools'

class Xscreensaver < Autotools
  description 'XScreenSaver is the standard screen saver collection shipped on most Linux and Unix systems running the X11 Window System.'
  homepage 'https://www.jwz.org/xscreensaver/download.html'
  version '6.16'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.jwz.org/xscreensaver/xscreensaver-#{version}.tar.gz"
  source_sha256 '91153c7c5b996761606dd7962c9f4bd4005a25874eac02776d0cf0026e6454e4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b50b3074a5659e8308e237eb54ad55d482f0a16b7b965c48bb78ae76ec9111f4',
     armv7l: 'b50b3074a5659e8308e237eb54ad55d482f0a16b7b965c48bb78ae76ec9111f4',
     x86_64: '794a609a9be4e96b4d78ef907cf9506ead6bd9e66f5266852ef7ffac28c59340'
  })

  depends_on 'at_spi2_core' => :executable
  depends_on 'cairo' => :executable
  depends_on 'coin' => :executable
  depends_on 'elogind' => :executable
  depends_on 'fontconfig' => :executable
  depends_on 'freeglut' => :executable
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'glfw' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'gtk3' => :executable
  depends_on 'harfbuzz' => :executable
  depends_on 'libglu' => :executable
  depends_on 'libglvnd' => :executable
  depends_on 'libice' => :executable
  depends_on 'libjpeg_turbo' => :executable
  depends_on 'libsm' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxcrypt' => :executable
  depends_on 'libxext' => :executable
  depends_on 'libxft' => :executable
  depends_on 'libxi' => :executable
  depends_on 'libxinerama' => :executable
  depends_on 'libxml2' => :executable
  depends_on 'libxrandr' => :executable
  depends_on 'libxrender' => :executable
  depends_on 'libxt' => :executable
  depends_on 'linux_pam' => :executable
  depends_on 'pango' => :executable
  depends_on 'sommelier' => :logical
  depends_on 'wayland' => :executable
  depends_on 'zlib' => :executable

  autotools_configure_options '--with-elogind --without-systemd'
  autotools_make_options 'all'
end
