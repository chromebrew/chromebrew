# Adapted from Arch Linux opencv PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/opencv/trunk/PKGBUILD

require 'buildsystems/cmake'

class Opencv < CMake
  description 'Open Source Computer Vision Library'
  homepage 'https://opencv.org/'
  version '5.1.0'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/opencv/opencv.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e0153ae9e4d29fe5f02b6818c1085012430b3736e3a6fb77fbb7c98e815e5bd2',
     armv7l: 'e0153ae9e4d29fe5f02b6818c1085012430b3736e3a6fb77fbb7c98e815e5bd2',
     x86_64: '38129aae57fca73c5014b4e0dcb7c877d7633b8bfaf58ea8b52b3b07b08a96ff'
  })

  depends_on 'ant' => :build
  depends_on 'cairo' => :library
  depends_on 'eigen' => :build
  depends_on 'ffmpeg' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glew' => :build
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gstreamer' => :library
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'hdf5' => :build
  depends_on 'lapack' => :build
  depends_on 'libavif' => :library
  depends_on 'libdc1394' => :build
  depends_on 'libgphoto' => :build
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libpng' => :library
  depends_on 'libtiff' => :library
  depends_on 'libwebp' => :library
  depends_on 'mesa' => :build
  depends_on 'openexr' => :library
  depends_on 'openjdk' => :build
  depends_on 'openjpeg' => :library
  depends_on 'protobuf' => :build
  depends_on 'py3_numpy' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'tbb' => :build
  depends_on 'zlib' => :library
end
