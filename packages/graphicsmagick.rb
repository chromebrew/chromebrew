require 'buildsystems/autotools'

class Graphicsmagick < Autotools
  description 'GraphicsMagick is the swiss army knife of image processing.'
  homepage 'http://www.graphicsmagick.org/'
  version "1.3.45-#{CREW_ICU_VER}"
  license 'MIT'
  compatibility 'all'
  # min_glibc (%w[x86_64 aarch64 armv7l].include?(ARCH) ? '2.37' : '2.23').to_s
  source_url "https://sourceforge.net/projects/graphicsmagick/files/graphicsmagick/#{version.split('-').first}/GraphicsMagick-#{version.split('-').first}.tar.xz"
  source_sha256 'dcea5167414f7c805557de2d7a47a9b3147bcbf617b91f5f0f4afe5e6543026b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd8948d929ef544c55b419425c1b4a31241dd08158d92d736cc4cfa07df1a3a3d',
     armv7l: 'd8948d929ef544c55b419425c1b4a31241dd08158d92d736cc4cfa07df1a3a3d',
       i686: '89c7656ef19583db7f87dd2c9720804151f3692f2c45bfc5f8357b642318195e',
     x86_64: 'e1613ff13635028ab6c927514f76de9dde3f1fce602c5765b431d6ba2857b43e'
  })

  if %w[x86_64 aarch64 armv7l].include?(ARCH)
    depends_on 'freetype' # R
    depends_on 'ghostscript' => :build
    depends_on 'harfbuzz' => :build
    depends_on 'jasper' # R
    depends_on 'libbsd' # R
    depends_on 'libde265' => :build
    depends_on 'libdeflate' # R
    depends_on 'libheif' # R
    depends_on 'libice' # R
    depends_on 'libjxl' # R
    depends_on 'libsm' # R
    depends_on 'libwebp' # R
    depends_on 'libwmf' # R
    depends_on 'libx11' # R
    depends_on 'libxau' # R
    depends_on 'libxcb' # R
    depends_on 'libxdmcp' # R
    depends_on 'libxext' # R
  end
  depends_on 'py3_docutils' => :build
  depends_on 'bzip2' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'jbigkit' # R
  depends_on 'lcms' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'libtiff' # R
  depends_on 'libtool' # R
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
    ConvenienceFunctions.libtoolize('jbig', 'jbigkit')
    ConvenienceFunctions.libtoolize('lzma', 'xzutils')
  end
end
