require 'package'

class Gegl < Package
  description 'GEGL (Generic Graphics Library) is a data flow based image processing framework, providing floating point processing and non-destructive image processing capabilities to GNU Image Manipulation Program and other projects.'
  homepage 'http://gegl.org/'
  version '0.4.18'
  source_url 'https://download.gimp.org/pub/gegl/0.4/gegl-0.4.18.tar.xz'
  source_sha256 'c946dfb45beb7fe0fb95b89a25395b449eda2b205ba3e8a1ffb1ef992d9eca64'

  binary_url ({
  })
  binary_sha256 ({
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
  depends_on 'meson' => :build

  def self.build
    system 'meson',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '_build'
    system 'ninja -v -C _build'
  end
  
  def self.check
    system 'ninja -C _build test'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
