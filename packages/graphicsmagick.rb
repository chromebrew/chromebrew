require 'package'

class Graphicsmagick < Package
  description 'GraphicsMagick is the swiss army knife of image processing.'
  homepage 'http://www.graphicsmagick.org/'
  version '1.3.40'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://sourceforge.net/projects/graphicsmagick/files/graphicsmagick/1.3.40/GraphicsMagick-1.3.40.tar.zst'
  source_sha256 '1c86bc8cdcfb7daa6d34940e1bccf82c201a27ecdcc65e8bb1089a4da6f2cfcc'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphicsmagick/1.3.40_armv7l/graphicsmagick-1.3.40-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphicsmagick/1.3.40_armv7l/graphicsmagick-1.3.40-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphicsmagick/1.3.40_x86_64/graphicsmagick-1.3.40-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '37e665f7b389b8f7a27cff67f10efbd5210e19e2f5bbe45167c6b11e2cd85eff',
     armv7l: '37e665f7b389b8f7a27cff67f10efbd5210e19e2f5bbe45167c6b11e2cd85eff',
     x86_64: 'a63ecd56ae08387fbd9d8db5817ab7a358d5894f8901f859d51609f513a87601'
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
  depends_on 'libjpeg' # R
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
  depends_on 'zlibpkg' # R
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
