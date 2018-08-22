require 'package'

class Gegl < Package
  description 'GEGL (Generic Graphics Library) is a data flow based image processing framework, providing floating point processing and non-destructive image processing capabilities to GNU Image Manipulation Program and other projects.'
  homepage 'http://gegl.org/'
  version '0.4.8'
  source_url 'https://download.gimp.org/pub/gegl/0.4/gegl-0.4.8.tar.bz2'
  source_sha256 '719468eec56ac5b191626a0cb6238f3abe9117e80594890c246acdc89183ae49'

  depends_on 'babl'
  depends_on 'json_glib'
  depends_on 'libjpeg_turbo'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.check
    system "make check"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
