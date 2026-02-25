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
    aarch64: '4936c541862b0886a0f0e8ee99732420c42079f65f0f0ba7eedf844bfabaa4e2',
     armv7l: '4936c541862b0886a0f0e8ee99732420c42079f65f0f0ba7eedf844bfabaa4e2',
     x86_64: 'f5e59a546262219b0e30ff490a8eed7b9667f813729f4dc5a0701003603a20ca'
  })

  depends_on 'ant' => :build
  depends_on 'cairo' # R
  depends_on 'eigen' => :build
  depends_on 'ffmpeg' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glew' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gstreamer' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'hdf5' => :build
  depends_on 'lapack' => :build
  depends_on 'libavif' # R
  depends_on 'libdc1394' => :build
  depends_on 'libgphoto' => :build
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'mesa' => :build
  depends_on 'openexr' # R
  depends_on 'openjdk' => :build
  depends_on 'openjpeg' # R
  depends_on 'protobuf' => :build
  depends_on 'py3_numpy' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'tbb' => :build
  depends_on 'zlib' # R
end
