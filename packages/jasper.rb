require 'buildsystems/cmake'

class Jasper < CMake
  description 'The JasPer Project is an open-source initiative to provide a free software-based reference implementation of the codec specified in the JPEG-2000 Part-1 standard (i.e., ISO/IEC 15444-1).'
  homepage 'https://www.ece.uvic.ca/~frodo/jasper/'
  version '4.2.8'
  license 'JasPer-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/jasper-software/jasper.git'
  git_hashtag "version-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd7cbe599c821f193b1bbae6f02dd85de4e53fafe687c592705d980a763cc0601',
     armv7l: 'd7cbe599c821f193b1bbae6f02dd85de4e53fafe687c592705d980a763cc0601',
     x86_64: 'f4f150c4c1cfc9b02cdb56f43ea402b1b0262b2fb71c5dce9d2eeca108371430'
  })

  depends_on 'freeglut' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglu' # R
  depends_on 'libglvnd' # R
  depends_on 'libheif' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libxi' # R
  depends_on 'libxmu' # R
  depends_on 'mesa' => :build
  depends_on 'shared_mime_info' => :build

  cmake_options '-DALLOW_IN_SOURCE_BUILD=ON \
        -DBUILD_SHARED_LIBS=ON \
        -DJAS_ENABLE_CXX=ON \
        -DJAS_ENABLE_DOC=OFF \
        -DJAS_ENABLE_HEIC_CODEC=ON \
        -DJAS_PACKAGING=ON'
end
