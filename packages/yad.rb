require 'buildsystems/autotools'

class Yad < Autotools
  description 'display graphical dialogs from shell scripts or command line.'
  homepage 'https://github.com/v1cont/yad'
  version '14.1'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/v1cont/yad.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aed62ef4ab23878851f8cba414244b5ffbfb7afe1af0f85260a810bc8feafc0d',
     armv7l: 'aed62ef4ab23878851f8cba414244b5ffbfb7afe1af0f85260a810bc8feafc0d',
     x86_64: 'aac4bf54b984da9242c9570a2d8bc667b2a60aac93224022cee76aad2693de31'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3'
  depends_on 'harfbuzz' # R
  depends_on 'pango' # R
  depends_on 'pkgconf' => :build
  depends_on 'rgb'
  depends_on 'zlib' # R

  autotools_pre_configure_options "PKG_CONFIG=#{CREW_PREFIX}/bin/pkgconf"
  autotools_configure_options "--enable-gio \
           --enable-icon-browser \
           --with-gtk=gtk3 \
           --with-rgb=#{CREW_PREFIX}/share/X11/rgb.txt"
end
