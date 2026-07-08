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
       i686: '439ed30a67a11fc68f19c26d826275ac6eb553f83851fc707954f703bf998438',
     x86_64: '1a6ed0b5a95a367b263ccb68ef47daaaeafc1bf5f820b51d4502dc7282eb67a7'
  })

  depends_on 'freeglut' => :executable
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'imake' => :build
  depends_on 'jbigkit' => :library
  depends_on 'libdeflate' => :library
  depends_on 'libglu' => :build
  depends_on 'libglvnd' => :executable
  depends_on 'libice' => :build
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libsm' => :build
  depends_on 'libx11' => :build
  depends_on 'libxi' => :executable
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
