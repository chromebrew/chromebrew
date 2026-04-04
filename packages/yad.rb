require 'buildsystems/autotools'

class Yad < Autotools
  description 'display graphical dialogs from shell scripts or command line.'
  homepage 'https://github.com/v1cont/yad'
  version '14.2'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/v1cont/yad.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1acf3efba04d8be0c28d3ae2b315267686968433e36a8979391101c61e615675',
     armv7l: '1acf3efba04d8be0c28d3ae2b315267686968433e36a8979391101c61e615675',
     x86_64: '0f5d4fb32a373699d3bd54242d37d63fee5bcb5233aefc04a616558835b6bbcf'
  })

  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'pango' => :library
  depends_on 'pkgconf' => :build
  depends_on 'rgb' => :library
  depends_on 'zlib' => :library

  autotools_pre_configure_options "PKG_CONFIG=#{CREW_PREFIX}/bin/pkgconf"
  autotools_configure_options "--enable-gio \
           --enable-icon-browser \
           --with-gtk=gtk3 \
           --with-rgb=#{CREW_PREFIX}/share/X11/rgb.txt"
end
