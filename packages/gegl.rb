require 'package'

class Gegl < Package
  description 'GEGL (Generic Graphics Library) is a data flow based image processing framework, providing floating point processing and non-destructive image processing capabilities to GNU Image Manipulation Program and other projects.'
  homepage 'http://gegl.org/'
  version '0.4.18'
  source_url 'https://download.gimp.org/pub/gegl/0.4/gegl-0.4.18.tar.xz'
  source_sha256 'c946dfb45beb7fe0fb95b89a25395b449eda2b205ba3e8a1ffb1ef992d9eca64'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gegl-0.4.18-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gegl-0.4.18-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gegl-0.4.18-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gegl-0.4.18-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ba5f9bed975025247a806682574df74ae7f18ea2d76e52c66a5f852fca8dfb38',
     armv7l: 'ba5f9bed975025247a806682574df74ae7f18ea2d76e52c66a5f852fca8dfb38',
       i686: '6d810e8b8bf7ede0936d2027b946645106737108ff29d784d81ba0970e54335f',
     x86_64: '5b5e18ae18dd26b7e4c315e9e612d5838d7e4189c7830e5b8a286bce4155faa7',
  })

  depends_on 'asciidoc'
  depends_on 'babl'
  depends_on 'enscript'
  depends_on 'gexiv2'
  depends_on 'graphviz'
  depends_on 'json_glib'
  depends_on 'lcms'
  depends_on 'libjpeg_turbo'
  depends_on 'librsvg'
  depends_on 'libwebp'
  depends_on 'luajit'
  depends_on 'openexr'
  depends_on 'vala'
  depends_on 'meson' => :build

  def self.patch
    # Fix meson.build:92:2: ERROR: Problem encountered: Unknown host architecture for arm builds.
    system "sed -i '91,92d' meson.build"
  end

  def self.build
    system 'meson',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '_build'
    system 'ninja -v -C _build'
  end
  
#  def self.check
#    system 'ninja -C _build test'
#  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
