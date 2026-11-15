require 'buildsystems/autotools'

class Imlib2 < Autotools
  description 'library that does image file loading and saving as well as rendering, manipulation, arbitrary polygon support, etc.'
  homepage 'https://sourceforge.net/projects/enlightenment/'
  version '1.13.0'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/enlightenment/imlib2-src/#{version}/imlib2-#{version}.tar.xz"
  source_sha256 '97d06c64f576de8a28b7e1ed78de0f7d11ec24db1823f1a0398b349515ff7216'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8125ec3dd0f41d01f0f777a816ad6a212ff97d247a16c6f9bc5bf5c392c09294',
     armv7l: '8125ec3dd0f41d01f0f777a816ad6a212ff97d247a16c6f9bc5bf5c392c09294',
     x86_64: 'd7f774c8be210eca8e720e74c96d3fd4b8a67f2abecd1ef88ab75e10a89954b4'
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
