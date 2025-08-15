require 'buildsystems/autotools'

class Graphicsmagick < Autotools
  description 'GraphicsMagick is the swiss army knife of image processing.'
  homepage 'http://www.graphicsmagick.org/'
  version "1.3.45-#{CREW_ICU_VER}"
  license 'MIT'
  compatibility 'all'
  # min_glibc (%w[x86_64 aarch64 armv7l].include?(ARCH) ? '2.37' : '2.23').to_s
  source_url "https://sourceforge.net/projects/graphicsmagick/files/graphicsmagick/#{version}/GraphicsMagick-#{version}.tar.xz"
  source_sha256 'dcea5167414f7c805557de2d7a47a9b3147bcbf617b91f5f0f4afe5e6543026b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd43124fbe8d5b9d83baee6a6f414de0cfebf3c8ece98b988bb1e4b15af70bb7d',
     armv7l: 'd43124fbe8d5b9d83baee6a6f414de0cfebf3c8ece98b988bb1e4b15af70bb7d',
       i686: '3e03732df5107a6c8617b785baae64d477ead57553087fafa31de0822d7f06fc',
     x86_64: '36081e952cf6c73855cf4b59770bf5b89ecfed1fe9f4f9a16105d8ebbd5b8113'
  })

  if %w[x86_64 aarch64 armv7l].include?(ARCH)
    depends_on 'freetype'
    depends_on 'ghostscript'
    depends_on 'harfbuzz'
    depends_on 'jasper'
    depends_on 'libde265'
    depends_on 'libdeflate' # R
    depends_on 'libheif'
    depends_on 'libjxl'
    depends_on 'libsm'
    depends_on 'libwebp'
    depends_on 'libwmf'
    depends_on 'libx11'
    depends_on 'libxext'
  end
  depends_on 'brotli' # R
  depends_on 'bzip2' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'highway' # R
  depends_on 'icu4c' # R
  depends_on 'jbigkit' # R
  depends_on 'lcms' # R
  depends_on 'libbsd' # R
  depends_on 'libice' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libmd' # R
  depends_on 'libpng' # R
  depends_on 'libtiff' # R
  depends_on 'libtool' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxml2' # R
  depends_on 'msttcorefonts' # L
  depends_on 'py3_docutils' => :build
  depends_on 'util_linux' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

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
    ConvenienceFunctions.libtoolize('lzma')
  end
end
