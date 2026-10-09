require 'buildsystems/autotools'

class Graphicsmagick < Autotools
  description 'GraphicsMagick is the swiss army knife of image processing.'
  homepage 'http://www.graphicsmagick.org/'
  version "1.3.49-#{CREW_ICU_VER}"
  license 'MIT'
  compatibility 'all'
  source_url "https://sourceforge.net/projects/graphicsmagick/files/graphicsmagick/#{version.split('-').first}/GraphicsMagick-#{version.split('-').first}.tar.xz"
  source_sha256 '7efa070dc31116b4315061b39f84bc7181e8b060bf61214ec9af851131af9c81'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '46eb36574c1edd4de560b1cd8a467b01b802cd0b263a09a5b6581cc4f783aea8',
     armv7l: '46eb36574c1edd4de560b1cd8a467b01b802cd0b263a09a5b6581cc4f783aea8',
       i686: '04dd68617657caf024c8f200c62f1f8145ff336277f48bfaeb31b2d53e474f12',
     x86_64: '577829d80aad216f35b3683f43f3d882ad1a3208bde9dc018ea4a2d01c0e76d5'
  })

  if %w[x86_64 aarch64 armv7l].include?(ARCH)
    depends_on 'freetype' => :library
    depends_on 'ghostscript' => :build
    depends_on 'harfbuzz' => :build
    depends_on 'jasper' => :library
    depends_on 'lcms' => :library
    depends_on 'libde265' => :build
    depends_on 'libdeflate' => :build
    depends_on 'libheif' => :library
    depends_on 'libice' => :library
    depends_on 'libjxl' => :library
    depends_on 'libsm' => :library
    depends_on 'libwebp' => :library
    depends_on 'libwmf' => :library
    depends_on 'freetype' => :library
    depends_on 'jasper' => :library
    depends_on 'lcms' => :library
    depends_on 'libheif' => :library
    depends_on 'libice' => :library
    depends_on 'libjxl' => :library
    depends_on 'libsm' => :library
    depends_on 'libwebp' => :library
    depends_on 'libwmf' => :library
  end
  depends_on 'py3_docutils' => :build
  depends_on 'bzip2' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'jbigkit' => :library
  depends_on 'libbsd' => :executable
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libpng' => :library
  depends_on 'libtiff' => :library
  depends_on 'libtool' => :library
  depends_on 'libx11' => :library
  depends_on 'libxau' => :executable
  depends_on 'libxcb' => :executable
  depends_on 'libxdmcp' => :executable
  depends_on 'libxext' => :library
  depends_on 'libxml2' => :library
  depends_on 'msttcorefonts' => :logical
  depends_on 'py3_docutils' => :build
  depends_on 'util_linux' => :executable
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  conflicts_with 'imagemagick7'
  no_env_options
  no_update_deps

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
