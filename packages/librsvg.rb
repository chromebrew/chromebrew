require 'package'

class Librsvg < Package
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version '2.52.8'
  license 'LGPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/librsvg.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.52.8_armv7l/librsvg-2.52.8-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.52.8_armv7l/librsvg-2.52.8-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.52.8_i686/librsvg-2.52.8-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.52.8_x86_64/librsvg-2.52.8-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3445bbd63ea8dd5c37285cb822cedaf9eb48fe040bbf40f46dbbb8e59c336d81',
     armv7l: '3445bbd63ea8dd5c37285cb822cedaf9eb48fe040bbf40f46dbbb8e59c336d81',
       i686: '50eef90138769cda46c1ab822bc756aa877f548026050e629d2654964060215b',
     x86_64: 'f84307e2d4c55dbd92d11e0b9184918304733b4c70ef7ffe09b183258de91bdf'
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
