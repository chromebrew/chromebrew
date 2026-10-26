require 'buildsystems/autotools'

class Xfce4_panel < Autotools
  description 'Next generation panel for the XFCE desktop environment'
  homepage 'https://xfce.org/'
  version '4.20.8'
  license 'GPL-2+ and LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://archive.xfce.org/src/xfce/xfce4-panel/#{version.sub(/\.\d+$/, '')}/xfce4-panel-#{version}.tar.bz2"
  source_sha256 'd69cb1f377953aeb1fb9bdbcef12c246bea66586e3f2868f3b758e0e8ce3d3fe'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fdef1186f229ee1b6cbb58f072b774466973f37144953c433f78c36feb6010cd',
     armv7l: 'fdef1186f229ee1b6cbb58f072b774466973f37144953c433f78c36feb6010cd',
     x86_64: 'f0c5922399bb1c86914ed65f92fc524239de23253fc76a4bd655725eace2556b'
  })

  depends_on 'at_spi2_core' => :library
  depends_on 'automake' => :executable
  depends_on 'cairo' => :library
  depends_on 'exo' => :library
  depends_on 'garcon' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gtk3' => :library
  depends_on 'libwnck' => :library
  depends_on 'libx11' => :library
  depends_on 'libxext' => :library
  depends_on 'libxfce4ui' => :library
  depends_on 'libxfce4util' => :library
  depends_on 'libxfce4windowing' => :library
  depends_on 'pango' => :library
  depends_on 'wayland' => :library
  depends_on 'xfconf' => :library

  def self.prebuild
    ConvenienceFunctions.libtoolize('libglib-2.0', 'glib')
  end

  def self.postinstall
    system 'gtk-update-icon-cache', '-f', '-t', "#{CREW_PREFIX}/share/icons/hicolor"
  end
end
