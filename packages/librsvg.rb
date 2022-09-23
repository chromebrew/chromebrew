require 'package'

class Librsvg < Package
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version '2.55.1'
  license 'LGPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/librsvg.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.55.1_armv7l/librsvg-2.55.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.55.1_armv7l/librsvg-2.55.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.55.1_i686/librsvg-2.55.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.55.1_x86_64/librsvg-2.55.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '951f7eef7aa09ff792a1b42a004f69098cd92a327d18146106eaea970d233968',
     armv7l: '951f7eef7aa09ff792a1b42a004f69098cd92a327d18146106eaea970d233968',
       i686: '9b21a71b73784056ec3143f78c87974a9f06415bc4f48595c7ceb8aa404549e0',
     x86_64: '6963f6819d9e73f78ffff35ae39c48650dad22071decaf74d57fc14db1806f80'
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
