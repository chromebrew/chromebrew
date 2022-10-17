require 'package'

class Librsvg < Package
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version '2.54.4'
  license 'LGPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/librsvg.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.54.4_armv7l/librsvg-2.54.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.54.4_armv7l/librsvg-2.54.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.54.4_i686/librsvg-2.54.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.54.4_x86_64/librsvg-2.54.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '58760d1112269cead225097aaac939ea5be45e2b10616bb8dff6ffbe421a68df',
     armv7l: '58760d1112269cead225097aaac939ea5be45e2b10616bb8dff6ffbe421a68df',
       i686: '01233045873ee26b638876acd32697ca2b9c5d80327c6aff04d6bdd840831527',
     x86_64: 'c8d079c44fe9017d16ec1b32aecd0c6e00e6143f02bd0a124fb9eb683d29a5a8'
  })

  depends_on 'fontconfig'
  depends_on 'harfbuzz'
  depends_on 'fribidi'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'harfbuzz'
  depends_on 'libcroco'
  depends_on 'libjpeg'
  depends_on 'pango'
  depends_on 'rust' => :build
  depends_on 'py3_six' => :build
  depends_on 'vala' => :build
  gnome

  def self.build
    # Following rustup modification as per https://github.com/rust-lang/rustup/issues/1167#issuecomment-367061388
    system 'rustup install stable --profile minimal || (rm -frv ~/.rustup/toolchains/* && rustup install stable --profile minimal)'
    system 'rustup default stable'
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "./configure \
      #{CREW_OPTIONS} \
      --enable-introspection=yes \
      --enable-vala=yes \
      --enable-pixbuf-loader \
      --disable-tools"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end

  def self.postinstall
    if File.exist?("#{CREW_PREFIX}/bin/gdk-pixbuf-query-loaders")
      system 'gdk-pixbuf-query-loaders',
             '--update-cache'
    end
  end
end
