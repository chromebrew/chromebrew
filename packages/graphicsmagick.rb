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
    aarch64: '7111a3289606c94417ff877bef81a94369d3c7c779bbc3a374f6125410faefb5',
     armv7l: '7111a3289606c94417ff877bef81a94369d3c7c779bbc3a374f6125410faefb5',
       i686: '1bf3cfd09dd51c174ad36a599656402182bd5ace6e6aae39b5b4ee1dcc599fd3',
     x86_64: '51708845a8ead29838003d724ff94d4eac7f8b2fe9e231029617a319057bb48d'
  })

  if %w[x86_64 aarch64 armv7l].include?(ARCH)
    depends_on 'bzip2' => :library
    depends_on 'freetype' => :library
    depends_on 'gcc_lib' => :library
    depends_on 'ghostscript' => :build
    depends_on 'glibc' => :library
    depends_on 'glibc_lib' => :library
    depends_on 'harfbuzz' => :build
    depends_on 'jasper' => :library
    depends_on 'jbigkit' => :library
    depends_on 'lcms' => :library
    depends_on 'libbsd' => :executable
    depends_on 'libbsd' => :library
    depends_on 'libde265' => :build
    depends_on 'libdeflate' => :build
    depends_on 'libheif' => :library
    depends_on 'libice' => :library
    depends_on 'libjpeg_turbo' => :library
    depends_on 'libjxl' => :library
    depends_on 'libpng' => :library
    depends_on 'libsm' => :library
    depends_on 'libtiff' => :library
    depends_on 'libtool' => :library
    depends_on 'libwebp' => :library
    depends_on 'libwmf' => :library
    depends_on 'libx11' => :library
    depends_on 'libxau' => :executable
    depends_on 'libxau' => :library
    depends_on 'libxcb' => :executable
    depends_on 'libxcb' => :library
    depends_on 'libxdmcp' => :executable
    depends_on 'libxdmcp' => :library
    depends_on 'libxext' => :library
    depends_on 'libxml2' => :library
    depends_on 'msttcorefonts' => :logical
    depends_on 'py3_docutils' => :build
    depends_on 'util_linux' => :executable
    depends_on 'util_linux' => :library
    depends_on 'xzutils' => :library
    depends_on 'zlib' => :library
    depends_on 'zstd' => :library
    depends_on 'bzip2' => :library
    depends_on 'freetype' => :library
    depends_on 'gcc_lib' => :library
    depends_on 'glibc' => :library
    depends_on 'glibc_lib' => :library
    depends_on 'jasper' => :library
    depends_on 'jbigkit' => :library
    depends_on 'lcms' => :library
    depends_on 'libheif' => :library
    depends_on 'libice' => :library
    depends_on 'libjpeg_turbo' => :library
    depends_on 'libjxl' => :library
    depends_on 'libpng' => :library
    depends_on 'libsm' => :library
    depends_on 'libtiff' => :library
    depends_on 'libtool' => :library
    depends_on 'libwebp' => :library
    depends_on 'libwmf' => :library
    depends_on 'libx11' => :library
    depends_on 'libxext' => :library
    depends_on 'libxml2' => :library
    depends_on 'xzutils' => :library
    depends_on 'zlib' => :library
    depends_on 'zstd' => :library
  end

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
