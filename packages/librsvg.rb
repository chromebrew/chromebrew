require 'package'

class Librsvg < Package
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  @_ver = '2.55.1'
  version "#{@_ver}-2"
  license 'LGPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/librsvg.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.55.1-2_armv7l/librsvg-2.55.1-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.55.1-2_armv7l/librsvg-2.55.1-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.55.1-2_i686/librsvg-2.55.1-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.55.1-2_x86_64/librsvg-2.55.1-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '20ced6237e0904c1f54975925007ac0a8f5d7a66c43526bf54d443ac81335108',
     armv7l: '20ced6237e0904c1f54975925007ac0a8f5d7a66c43526bf54d443ac81335108',
       i686: 'b083b593deb1f4ea719eec3cea14b99328b50a77bc604f2f276418ec4c315e9c',
     x86_64: 'd850dce4e8290134d7c6a53c859c3bbd9229732123db450bf13aa4652035795f'
  })

  depends_on 'fontconfig'
  depends_on 'harfbuzz'
  depends_on 'fribidi'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'harfbuzz'
  depends_on 'icu4c'
  depends_on 'libcroco'
  depends_on 'libjpeg'
  depends_on 'pango'
  depends_on 'py3_smartypants' => :build
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
      --enable-pixbuf-loader"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end

  def self.postinstall
    return unless File.exist?("#{CREW_PREFIX}/bin/gdk-pixbuf-query-loaders")

    system 'gdk-pixbuf-query-loaders',
           '--update-cache'
  end
end
