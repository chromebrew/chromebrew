require 'package'

class Librsvg < Package
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  @_ver = '2.55.91'
  version @_ver
  license 'LGPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/librsvg.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.55.91_armv7l/librsvg-2.55.91-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.55.91_armv7l/librsvg-2.55.91-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.55.91_i686/librsvg-2.55.91-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.55.91_x86_64/librsvg-2.55.91-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ddc33a6810e6759d26089586648a52f4eee799e605e8538e36720905d42d0264',
     armv7l: 'ddc33a6810e6759d26089586648a52f4eee799e605e8538e36720905d42d0264',
       i686: 'fdc274ddb62267b9cf5014132c6633753ac5e1a51be880776fa74bb0d02a4376',
     x86_64: '10094c5a19052f73b7e59de9c7c6966213eadd63c7982dd4016fef0f9d63cc1f'
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
  depends_on 'expat' # R
  depends_on 'freetype' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'libpng' # R
  depends_on 'libxml2' # R
  depends_on 'zlibpkg' # R
  depends_on 'cairo' # R

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
