require 'buildsystems/autotools'

class Imlib2 < Autotools
  description 'library that does image file loading and saving as well as rendering, manipulation, arbitrary polygon support, etc.'
  homepage 'https://sourceforge.net/projects/enlightenment/'
  version '1.12.5'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://sourceforge.net/projects/enlightenment/files/imlib2-src/#{version.split('-').first}/imlib2-#{version.split('-').first}.tar.xz"
  source_sha256 'fa2315f28379b430a6e6605b4284b07be06a3ef422d4f5e1c9bb24714c4cf6dd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7a0d4d31970a5f4cf2d0c9ba47b66f176cffbe801fa01220fe600d58c3048fc0',
     armv7l: '7a0d4d31970a5f4cf2d0c9ba47b66f176cffbe801fa01220fe600d58c3048fc0',
     x86_64: '7dacae0624fcec95d158c4abd8ed10c8cc5eaecc999685c139900b10c74dc2fb'
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
