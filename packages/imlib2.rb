require 'buildsystems/autotools'

class Imlib2 < Autotools
  description 'library that does image file loading and saving as well as rendering, manipulation, arbitrary polygon support, etc.'
  homepage 'https://sourceforge.net/projects/enlightenment/'
  version '1.12.6'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/enlightenment/imlib2-src/#{version}/imlib2-#{version}.tar.xz"
  source_sha256 '250f9752f69dc522e529a81aaa9395705f7fc312ff2453e5de59ac2ba1f2858f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5012edbb6108b16c76c11cec5236daf3a520d414d7bd1c4ee9463082e0e8f440',
     armv7l: '5012edbb6108b16c76c11cec5236daf3a520d414d7bd1c4ee9463082e0e8f440',
     x86_64: '32d0498a80b9123c59259ac059adebefb36a47908e8b98ee7e1d7f76a10ca1d0'
  })

  depends_on 'bzip2' # R
  depends_on 'cairo' # R
  depends_on 'fontconfig' => :build
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'giflib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'jbigkit' # R
  depends_on 'libbsd' # R
  depends_on 'libdeflate' # R
  depends_on 'libheif' # R
  depends_on 'libid3tag' => :build
  depends_on 'libjpeg_turbo' # R
  depends_on 'libjxl' # R
  depends_on 'libpng' # R
  depends_on 'librsvg' # R
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R
  depends_on 'openjpeg' # R
  depends_on 'protobuf_c' => :build
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  autotools_configure_options "--sysconfdir=#{CREW_PREFIX}/etc/imlib2 \
      --x-libraries=#{CREW_LIB_PREFIX}"

  def self.prebuild
    ConvenienceFunctions.libtoolize('jbig', 'jbigkit')
  end
end
