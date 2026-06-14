require 'buildsystems/cmake'

class Jasper < CMake
  description 'The JasPer Project is an open-source initiative to provide a free software-based reference implementation of the codec specified in the JPEG-2000 Part-1 standard (i.e., ISO/IEC 15444-1).'
  homepage 'https://www.ece.uvic.ca/~frodo/jasper/'
  version '4.2.9'
  license 'JasPer-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/jasper-software/jasper.git'
  git_hashtag "version-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b7c062198dbb54ed7b4280dd4ba931beea277a768ee8aed97fd11514bcb007f7',
     armv7l: 'b7c062198dbb54ed7b4280dd4ba931beea277a768ee8aed97fd11514bcb007f7',
     x86_64: '36cacc1130e0ffc69c29ba6533c8fb07cd3d93fbd0a677d12c2e5601624affcc'
  })

  depends_on 'freeglut' => :executable
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libglu' => :executable
  depends_on 'libglvnd' => :executable
  depends_on 'libheif' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libxi' => :executable
  depends_on 'libxmu' => :executable
  depends_on 'mesa' => :build
  depends_on 'shared_mime_info' => :build

  cmake_options '-DALLOW_IN_SOURCE_BUILD=ON \
        -DBUILD_SHARED_LIBS=ON \
        -DJAS_ENABLE_CXX=ON \
        -DJAS_ENABLE_DOC=OFF \
        -DJAS_ENABLE_HEIC_CODEC=ON \
        -DJAS_PACKAGING=ON'
end
