require 'buildsystems/cmake'

class Libwebp < CMake
  description 'WebP is a modern image format that provides superior lossless and lossy compression for images on the web.'
  homepage 'https://developers.google.com/speed/webp/'
  version '1.6.0'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/webmproject/libwebp.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '64e92520924b6f294bf617fb53f1731869c408f4fd4b32849dc6b7c4e47cbc8e',
     armv7l: '64e92520924b6f294bf617fb53f1731869c408f4fd4b32849dc6b7c4e47cbc8e',
     x86_64: '6928c7a7de2fa9fc1f937a303c7804db849d496c547c972ffa1ceae757364012'
  })

  depends_on 'freeglut' # R
  depends_on 'gcc_lib' # R
  depends_on 'giflib' # R
  depends_on 'glibc' # R
  depends_on 'jbigkit' # R
  depends_on 'libdeflate' # R
  depends_on 'libglu' # R
  depends_on 'libglvnd' # R
  depends_on 'libice' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'libsdl' => :build
  depends_on 'libsm' # R
  depends_on 'libtiff' # R
  depends_on 'libx11' # R
  depends_on 'libxi' # R
  depends_on 'libxmu' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  gnome

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
