require 'buildsystems/autotools'

class Imlib2 < Autotools
  description 'library that does image file loading and saving as well as rendering, manipulation, arbitrary polygon support, etc.'
  homepage 'https://sourceforge.net/projects/enlightenment/'
  version '1.12.7'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/enlightenment/imlib2-src/#{version}/imlib2-#{version}.tar.xz"
  source_sha256 'd71ee5351cc1914fb01968123d0dcf276740e5af5662943ac47ae60cafa4d13b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b0a2d92e3ab3ab5ffcfad129338aeb955d4a50d7a9f8081eebbf04f8c3f14948',
     armv7l: 'b0a2d92e3ab3ab5ffcfad129338aeb955d4a50d7a9f8081eebbf04f8c3f14948',
     x86_64: '3e5c44043604db0b0e57d7417a8b9fe1a08ad711f480b273b681328fa75b6a61'
  })

  depends_on 'bzip2' => :library
  depends_on 'cairo' => :library
  depends_on 'fontconfig' => :build
  depends_on 'freetype' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'giflib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'jbigkit' => :library
  depends_on 'libbsd' => :executable
  depends_on 'libdeflate' => :library
  depends_on 'libheif' => :library
  depends_on 'libid3tag' => :build
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libjxl' => :library
  depends_on 'libpng' => :library
  depends_on 'librsvg' => :library
  depends_on 'libtiff' => :library
  depends_on 'libwebp' => :library
  depends_on 'libx11' => :library
  depends_on 'libxau' => :executable
  depends_on 'libxcb' => :library
  depends_on 'libxdmcp' => :executable
  depends_on 'libxext' => :library
  depends_on 'openjpeg' => :library
  depends_on 'protobuf_c' => :build
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  autotools_configure_options "--sysconfdir=#{CREW_PREFIX}/etc/imlib2 \
      --x-libraries=#{CREW_LIB_PREFIX}"

  def self.prebuild
    ConvenienceFunctions.libtoolize('jbig', 'jbigkit')
  end
end
