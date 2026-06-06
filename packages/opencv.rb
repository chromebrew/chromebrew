# Adapted from Arch Linux opencv PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/opencv/trunk/PKGBUILD

require 'buildsystems/cmake'

class Opencv < CMake
  description 'Open Source Computer Vision Library'
  homepage 'https://opencv.org/'
  version '5.0.0'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/opencv/opencv.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ec7a825c824df5956f3bc316668b4da650938504b9439674d2d94981244fdd5f',
     armv7l: 'ec7a825c824df5956f3bc316668b4da650938504b9439674d2d94981244fdd5f',
     x86_64: 'b0ecd17df0ae8182447888e68765314f4acaa7e3193042c54951caef9be9e6de'
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
  depends_on 'harfbuzz' # R
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
