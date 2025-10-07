require 'package'

class Libtiff < Package
  description 'LibTIFF provides support for the Tag Image File Format (TIFF), a widely used format for storing image data.'
  homepage 'http://www.libtiff.org/'
  version '4.7.1'
  license 'libtiff'
  compatibility 'all'
  source_url "https://download.osgeo.org/libtiff/tiff-#{version}.tar.xz"
  source_sha256 'b92017489bdc1db3a4c97191aa4b75366673cb746de0dce5d7a749d5954681ba'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1ac9f8425b9dc95a4895abf6d593e14a15696f3bc0b2464c2467e74ddeaba9d5',
     armv7l: '1ac9f8425b9dc95a4895abf6d593e14a15696f3bc0b2464c2467e74ddeaba9d5',
       i686: '535c1315f1de95bf13a13d5222ba99f626bf4511e298699771e29c63867a5b0b',
     x86_64: '273da7543a57e58339b456c4b9ea6194236a8a606e81faa97b04af8842a48ba6'
  })

  depends_on 'freeglut' unless ARCH == 'i686' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'imake' => :build
  depends_on 'jbigkit' # R
  depends_on 'libdeflate' # R
  depends_on 'libglu' unless ARCH == 'i686' # R
  depends_on 'libglvnd' unless ARCH == 'i686' # R
  depends_on 'libice' unless ARCH == 'i686' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libsm' unless ARCH == 'i686' # R
  depends_on 'libwebp' unless ARCH == 'i686' # R
  depends_on 'libx11' unless ARCH == 'i686' # R
  depends_on 'libxi' unless ARCH == 'i686' # R
  depends_on 'mesa' => :build unless ARCH == 'i686'
  depends_on 'wget2' => :build
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  gnome
  no_env_options

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    @x = ARCH == 'i686' ? '' : '--with-x --enable-webp'
    system "#{CREW_ENV_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} ./configure #{CREW_CONFIGURE_OPTIONS} \
      #{@x} \
      --enable-zlib \
      --enable-mdi \
      --enable-libdeflate \
      --enable-pixarlog \
      --enable-jpeg \
      --enable-lzma \
      --enable-zstd \
      --enable-cxx"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Remove static library.
    FileUtils.rm "#{CREW_DEST_LIB_PREFIX}/libtiff.a"
  end
end
