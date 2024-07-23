require 'package'

class Libtiff < Package
  description 'LibTIFF provides support for the Tag Image File Format (TIFF), a widely used format for storing image data.'
  homepage 'http://www.libtiff.org/'
  version '4.6.0'
  license 'libtiff'
  compatibility 'all'
  source_url 'https://download.osgeo.org/libtiff/tiff-4.6.0.tar.xz'
  source_sha256 'e178649607d1e22b51cf361dd20a3753f244f022eefab1f2f218fc62ebaf87d2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c07999f1adeab936eb8f5f95f3a538abee49a7807ae83059b4aa8118140285b0',
     armv7l: 'c07999f1adeab936eb8f5f95f3a538abee49a7807ae83059b4aa8118140285b0',
       i686: '7f9546738a572a655c77cf0276b10f50b20d1d074f998928e5103f6e8b07bf6a',
     x86_64: '1e96c774a4e20cc55d62139080206c20476e6ac7ed0340191673de35eca7c125'
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
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  gnome
  no_env_options

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    @x = ARCH == 'i686' ? '' : '--with-x --enable-webp'
    system "#{CREW_ENV_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} ./configure #{CREW_OPTIONS} \
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
