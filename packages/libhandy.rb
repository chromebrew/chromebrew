require 'package'

class Libhandy < Package
  description 'The aim of the handy library is to help with developing UI for mobile devices using GTK/GNOME.'
  homepage 'https://gitlab.gnome.org/GNOME/libhandy/'
  version '1.8.2'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libhandy.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '098d79435b7b77ff94762642bcd2ff9ae85f586bbc3677982a4a45e7015876bd',
     armv7l: '098d79435b7b77ff94762642bcd2ff9ae85f586bbc3677982a4a45e7015876bd',
     x86_64: '450a043658082a07a1a562ebf28ec053d97e567daad736ffbc8b3de4e61f09fc'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' => :build
  depends_on 'fribidi' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libjpeg' => :build
  depends_on 'pango' # R
  depends_on 'vala' => :build
  depends_on 'zlibpkg' # R

  def self.build
    system "mold -run meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure --no-pager builddir'
    system "mold -run #{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
