require 'buildsystems/cmake'

class Libtiff < CMake
  description 'LibTIFF provides support for the Tag Image File Format (TIFF), a widely used format for storing image data.'
  homepage 'http://www.libtiff.org/'
  version '4.7.2'
  license 'libtiff'
  compatibility 'all'
  source_url 'https://github.com/libsdl-org/libtiff.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e65411777c8eda46b9daad9868d19f7948c1ec16e222b8e40736f95be0eac4ad',
     armv7l: 'e65411777c8eda46b9daad9868d19f7948c1ec16e222b8e40736f95be0eac4ad',
       i686: '47538b362b03d6c713ada6c303451bd24f5e68e0c62bd182006c2bbae4a6c4b0',
     x86_64: '1a6ed0b5a95a367b263ccb68ef47daaaeafc1bf5f820b51d4502dc7282eb67a7'
  })

  depends_on 'freeglut' => :executable
  depends_on 'freeglut' unless ARCH == 'i686' # R
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'imake' => :build
  depends_on 'jbigkit' => :library
  depends_on 'libdeflate' => :library
  depends_on 'libglu' unless ARCH == 'i686' # R
  depends_on 'libglvnd' => :executable
  depends_on 'libglvnd' unless ARCH == 'i686' # R
  depends_on 'libice' unless ARCH == 'i686' # R
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libsm' unless ARCH == 'i686' # R
  depends_on 'libx11' unless ARCH == 'i686' # R
  depends_on 'libxi' => :executable
  depends_on 'libxi' unless ARCH == 'i686' # R
  depends_on 'mesa' => :build unless ARCH == 'i686'
  depends_on 'sphinx' => :build
  depends_on 'wget2' => :build
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  gnome

  cmake_options '-DBUILD_SHARED_LIBS=ON \
                 -Dtiff-static=OFF \
                 -Dtiff-tests=OFF \
                 -Dtiff-contrib=OFF'
end
