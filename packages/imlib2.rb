require 'buildsystems/autotools'

class Imlib2 < Autotools
  description 'library that does image file loading and saving as well as rendering, manipulation, arbitrary polygon support, etc.'
  homepage 'https://sourceforge.net/projects/enlightenment/'
  version "1.12.3-#{CREW_ICU_VER}"
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://sourceforge.net/projects/enlightenment/files/imlib2-src/#{version.split('-').first}/imlib2-#{version.split('-').first}.tar.xz"
  source_sha256 '96244656576a3e0a6f58b78e514ddc919622ac6806711bc231837eee62c1de34'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'efcce21c77145b6db2823bb7a0d5cccb83ebd5e59163cc21ffe3ea2ecc8fca4e',
     armv7l: 'efcce21c77145b6db2823bb7a0d5cccb83ebd5e59163cc21ffe3ea2ecc8fca4e',
     x86_64: 'b58d6d00929472e6b5f738e84d361e7922ab45dd3a0c270f1c9652dda1e836d9'
  })

  depends_on 'bzip2' # R
  depends_on 'cairo' # R
  depends_on 'expat' # R
  depends_on 'fontconfig' => :build
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'giflib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'jbigkit' # R
  depends_on 'libbsd' # R
  depends_on 'libdeflate' # R
  depends_on 'libheif' # R
  depends_on 'libid3tag' => :build
  depends_on 'libjpeg_turbo' # R
  depends_on 'libjxl' # R
  depends_on 'libmd' # R
  depends_on 'libpng' # R
  depends_on 'librsvg' # R
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R
  depends_on 'libxml2' # R
  depends_on 'openjpeg' # R
  depends_on 'pango' # R
  depends_on 'protobuf_c' => :build
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  autotools_configure_options "--sysconfdir=#{CREW_PREFIX}/etc/imlib2 \
      --x-libraries=#{CREW_LIB_PREFIX}"
end
