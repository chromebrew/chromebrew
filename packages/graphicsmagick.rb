require 'package'

class Graphicsmagick < Package
  description 'GraphicsMagick is the swiss army knife of image processing.'
  homepage 'http://www.graphicsmagick.org/'
  version '1.3.43-icu75.1'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://sourceforge.net/projects/graphicsmagick/files/graphicsmagick/1.3.43/GraphicsMagick-1.3.43.tar.xz'
  source_sha256 '2b88580732cd7e409d9e22c6116238bef4ae06fcda11451bf33d259f9cbf399f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aeff59b26a27af04fd89485d29b4375be3b526eaebef964a22ec8c027082467e',
     armv7l: 'aeff59b26a27af04fd89485d29b4375be3b526eaebef964a22ec8c027082467e',
     x86_64: 'd10dba42f7cdf317ef437c4fdd6500d7cce82eb1fc56e9596e1a494f3b13cda1'
  })

  depends_on 'brotli' # R
  depends_on 'bzip2' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'ghostscript' => :build
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'highway' # R
  depends_on 'icu4c' # R
  depends_on 'jasper' # R
  depends_on 'jbigkit' # R
  depends_on 'lcms' # R
  depends_on 'libbsd' # R
  depends_on 'libde265' # R
  depends_on 'libdeflate' # R
  depends_on 'libheif' # R
  depends_on 'libice' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libjxl' # R
  depends_on 'libmd' # R
  depends_on 'libpng' # R
  depends_on 'libsm' # R
  depends_on 'libtiff' # R
  depends_on 'libtool' # R
  depends_on 'libwebp' # R
  depends_on 'libwmf' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R
  depends_on 'libxml2' # R
  depends_on 'msttcorefonts' # L
  depends_on 'py3_docutils' => :build
  depends_on 'util_linux' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  no_env_options

  def self.build
    system "#{CREW_ENV_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} ./configure #{CREW_OPTIONS} \
      --with-windows-font-dir=#{CREW_PREFIX}/share/fonts/truetype/msttcorefonts \
      --with-perl=#{CREW_PREFIX}/bin/perl \
      --disable-maintainer-mode \
      --enable-magick-compat \
      --enable-shared=yes \
      --enable-static=no \
      --with-modules \
      --with-perl \
      --with-x \
      --with-xml"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
