require 'buildsystems/autotools'

class Yad < Autotools
  description 'display graphical dialogs from shell scripts or command line.'
  homepage 'https://github.com/v1cont/yad'
  version '15.0'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/v1cont/yad.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0366a192101121c8ea8551d74df855c3bd152fe7aca6c3251caf4e06c6926700',
     armv7l: '0366a192101121c8ea8551d74df855c3bd152fe7aca6c3251caf4e06c6926700',
     x86_64: '39c54f5f8f6068bccd98245e5eb96af04ac6ea4fcee458cdf48f5e9830084943'
  })

  depends_on 'at_spi2_core' => :executable
  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :executable
  depends_on 'cairo' => :library
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :executable
  depends_on 'glib' => :library
  depends_on 'glibc' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :executable
  depends_on 'gtk3' => :executable
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :executable
  depends_on 'harfbuzz' => :library
  depends_on 'pango' => :executable
  depends_on 'pango' => :library
  depends_on 'pkgconf' => :build
  depends_on 'rgb' => :library
  depends_on 'zlib' => :executable
  depends_on 'zlib' => :library

  autotools_pre_configure_options "PKG_CONFIG=#{CREW_PREFIX}/bin/pkgconf"
  autotools_configure_options "--enable-gio \
           --enable-icon-browser \
           --with-gtk=gtk3 \
           --with-rgb=#{CREW_PREFIX}/share/X11/rgb.txt"
end
