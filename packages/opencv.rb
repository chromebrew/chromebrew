# Adapted from Arch Linux opencv PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/opencv/trunk/PKGBUILD

require 'buildsystems/cmake'

class Opencv < CMake
  description 'Open Source Computer Vision Library'
  homepage 'https://opencv.org/'
  version '4.13.0'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/opencv/opencv.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9d9aacc2ecc3e54fa78057498456e235304c4f11f2e834d4120961b69070b0ea',
     armv7l: '9d9aacc2ecc3e54fa78057498456e235304c4f11f2e834d4120961b69070b0ea',
     x86_64: '472ca926ca8cf52d5ee45b609c329e955630920a8116663d25d1dc38cf649c33'
  })

  depends_on 'tbb' => :build
  depends_on 'openexr' => :build
  depends_on 'gstreamer' => :build
  depends_on 'libdc1394' => :build
  depends_on 'lapack' => :build
  depends_on 'libavif' => :build
  depends_on 'libgphoto' => :build
  depends_on 'openjpeg' => :build
  depends_on 'ffmpeg' => :build
  depends_on 'protobuf' => :build
  depends_on 'cmake' => :build
  depends_on 'py3_numpy' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'mesa' => :build
  depends_on 'eigen' => :build
  depends_on 'hdf5' => :build
  depends_on 'glew' => :build
  depends_on 'ant' => :build
  depends_on 'openjdk' => :build
end
