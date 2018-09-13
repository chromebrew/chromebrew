require 'package'

class Gegl < Package
  description 'GEGL (Generic Graphics Library) is a data flow based image processing framework, providing floating point processing and non-destructive image processing capabilities to GNU Image Manipulation Program and other projects.'
  homepage 'http://gegl.org/'
  version '0.4.8'
  source_url 'https://download.gimp.org/pub/gegl/0.4/gegl-0.4.8.tar.bz2'
  source_sha256 '719468eec56ac5b191626a0cb6238f3abe9117e80594890c246acdc89183ae49'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gegl-0.4.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gegl-0.4.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gegl-0.4.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gegl-0.4.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ab2f5a9ab05edc387fa5ff9b548ae25acf5085afdfef655c79787912a3593d81',
     armv7l: 'ab2f5a9ab05edc387fa5ff9b548ae25acf5085afdfef655c79787912a3593d81',
       i686: '9fbfc23e510a0b1534625ddbdac465716f5da41c9f7fa8e816264d192d2653ed',
     x86_64: 'c00defcb1a8e58fbf7e9c7c94e8bfd684abb36281453252b0103b300034fa843',
  })

  depends_on 'babl'
  depends_on 'gexiv2'
  depends_on 'graphviz'
  depends_on 'json_glib'
  depends_on 'lcms'
  depends_on 'libjpeg_turbo'
  depends_on 'librsvg'
  depends_on 'libwebp'
  depends_on 'lua'
  depends_on 'vala'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode',
           '--disable-docs'
    system 'make'
  end

  def self.check
    system "make check"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
