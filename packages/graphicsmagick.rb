require 'buildsystems/autotools'

class Graphicsmagick < Autotools
  description 'GraphicsMagick is the swiss army knife of image processing.'
  homepage 'http://www.graphicsmagick.org/'
  version "1.3.48-#{CREW_ICU_VER}"
  license 'MIT'
  compatibility 'all'
  source_url "https://sourceforge.net/projects/graphicsmagick/files/graphicsmagick/#{version.split('-').first}/GraphicsMagick-#{version.split('-').first}.tar.xz"
  source_sha256 '9218eb78179110f91371066ab75cb3b4dd034b9bb464b29ce9bab7a11979232b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '159b74b99d80db7f7994726d4e2f4e16ffd57ad6f7dc7aee7ecf48e95df4ff72',
     armv7l: '159b74b99d80db7f7994726d4e2f4e16ffd57ad6f7dc7aee7ecf48e95df4ff72',
       i686: '9cca73b6a72c8d1824eb481bd4d27c66e779192c3a4e98553f44b2ee07e98f0a',
     x86_64: '3ad8b2bc8b8f6c015db2cd4448b49f2cfed3cbc50f50b8dfda39e8db3fa8e6de'
  })

  if %w[x86_64 aarch64 armv7l].include?(ARCH)
    depends_on 'freetype' => :library
    depends_on 'ghostscript' => :build
    depends_on 'harfbuzz' => :build
    depends_on 'jasper' => :library
    depends_on 'lcms' => :library
    depends_on 'libbsd' => :library
    depends_on 'libde265' => :build
    depends_on 'libdeflate' => :build
    depends_on 'libheif' => :library
    depends_on 'libice' => :library
    depends_on 'libjxl' => :library
    depends_on 'libsm' => :library
    depends_on 'libwebp' => :library
    depends_on 'libwmf' => :library
    depends_on 'libx11' => :library
    depends_on 'libxau' => :library
    depends_on 'libxcb' => :library
    depends_on 'libxdmcp' => :library
    depends_on 'libxext' => :library
    depends_on 'xzutils' => :library
    depends_on 'freetype' => :library
    depends_on 'gcc_lib' => :library
    depends_on 'jasper' => :library
    depends_on 'lcms' => :library
    depends_on 'libbsd' => :library
    depends_on 'libheif' => :library
    depends_on 'libice' => :library
    depends_on 'libjxl' => :library
    depends_on 'libsm' => :library
    depends_on 'libwebp' => :library
    depends_on 'libwmf' => :library
    depends_on 'libx11' => :library
    depends_on 'libxau' => :library
    depends_on 'libxcb' => :library
    depends_on 'libxdmcp' => :library
    depends_on 'libxext' => :library
  end
  depends_on 'py3_docutils' => :build
  depends_on 'bzip2' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'jbigkit' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libpng' => :library
  depends_on 'libtiff' => :library
  depends_on 'libtool' => :library
  depends_on 'libxml2' => :library
  depends_on 'msttcorefonts' => :logical
  depends_on 'py3_docutils' => :build
  depends_on 'util_linux' => :library
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  no_env_options

  autotools_configure_options "--with-windows-font-dir=#{CREW_PREFIX}/share/fonts/truetype/msttcorefonts \
      --with-perl=#{CREW_PREFIX}/bin/perl \
      --disable-maintainer-mode \
      --enable-magick-compat \
      --enable-shared=yes \
      --enable-static=no \
      --with-modules \
      --with-perl \
      #{'--with-x' if %w[x86_64 aarch64 armv7l].include?(ARCH)} \
      --with-xml"

  def self.prebuild
    ConvenienceFunctions.libtoolize('jbig', 'jbigkit')
    ConvenienceFunctions.libtoolize('lzma', 'xzutils')
    ConvenienceFunctions.libtoolize('libuuid', 'util_linux')
  end
end
