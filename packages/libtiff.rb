require 'buildsystems/cmake'

class Libtiff < CMake
  description 'LibTIFF provides support for the Tag Image File Format (TIFF), a widely used format for storing image data.'
  homepage 'http://www.libtiff.org/'
  version '4.7.1-1'
  license 'libtiff'
  compatibility 'all'
  source_url 'https://github.com/libsdl-org/libtiff.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '95226e90392eed108b5863a692f2c4bd39a1c524e1f330868e2f471655008310',
     armv7l: '95226e90392eed108b5863a692f2c4bd39a1c524e1f330868e2f471655008310',
       i686: 'ae9cbd6400afb1f4423fefe190336be4c9d90dec3b9aa2364e32f8fb837cb555',
     x86_64: '1199576773668006bc8af5553deffda57a45e18c6b2d3654c0f87595ae721d74'
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
  depends_on 'libx11' unless ARCH == 'i686' # R
  depends_on 'libxi' unless ARCH == 'i686' # R
  depends_on 'mesa' => :build unless ARCH == 'i686'
  depends_on 'sphinx' => :build
  depends_on 'wget2' => :build
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  gnome

  cmake_options '-DBUILD_SHARED_LIBS=ON \
                 -Dtiff-static=OFF \
                 -Dtiff-tests=OFF \
                 -Dtiff-contrib=OFF'
end
