require 'package'

class Gegl < Package
  description 'GEGL (Generic Graphics Library) is a data flow based image processing framework, providing floating point processing and non-destructive image processing capabilities to GNU Image Manipulation Program and other projects.'
  homepage 'http://gegl.org/'
  version '0.4.22'
  compatibility 'all'
  source_url 'https://download.gimp.org/pub/gegl/0.4/gegl-0.4.22.tar.xz'
  source_sha256 '1888ec41dfd19fe28273795c2209efc1a542be742691561816683990dc642c61'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gegl-0.4.22-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gegl-0.4.22-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gegl-0.4.22-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gegl-0.4.22-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b96e1964c8b842c855ad08a8fa12c1ca1df48745b75c8a7210e4e91e55f1bbd6',
     armv7l: 'b96e1964c8b842c855ad08a8fa12c1ca1df48745b75c8a7210e4e91e55f1bbd6',
       i686: 'f47a712d92c1cd4b3293eac5a9cf6d5597162b73f4f7879dea18273b679da4b0',
     x86_64: '04bb398c76229e19c6936d1d3e5fea733345db9055b517257f6f39b73201e0a6',
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
  
  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
