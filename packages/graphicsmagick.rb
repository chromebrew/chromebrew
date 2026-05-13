require 'buildsystems/autotools'

class Graphicsmagick < Autotools
  description 'GraphicsMagick is the swiss army knife of image processing.'
  homepage 'http://www.graphicsmagick.org/'
  version "1.3.46-#{CREW_ICU_VER}"
  license 'MIT'
  compatibility 'all'
  source_url "https://sourceforge.net/projects/graphicsmagick/files/graphicsmagick/#{version.split('-').first}/GraphicsMagick-#{version.split('-').first}.tar.xz"
  source_sha256 'c7c706a505e9c6c3764156bb94a0c9644d79131785df15a89c9f8721d1abd061'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd8948d929ef544c55b419425c1b4a31241dd08158d92d736cc4cfa07df1a3a3d',
     armv7l: 'd8948d929ef544c55b419425c1b4a31241dd08158d92d736cc4cfa07df1a3a3d',
       i686: '7a2577c920929732ea642265ed7d0bdd39aae442ecd1cb7c423be748523be7a8',
     x86_64: 'a7830399756d05b03fd960259a3df5c590f43f4a2eaa07864ece9a1112a5c9a4'
  })

  if %w[x86_64 aarch64 armv7l].include?(ARCH)
    depends_on 'freetype' => :library
    depends_on 'gcc_lib' => :library
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
