require 'buildsystems/cmake'

class Plplot < CMake
  description 'PLplot is a cross-platform software package for creating scientific plots'
  homepage 'https://plplot.sourceforge.net/'
  version '5.15.0'
  license 'LGPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/plplot/plplot/#{version}%20Source/plplot-#{version}.tar.gz"
  source_sha256 'b92de4d8f626a9b20c84fc94f4f6a9976edd76e33fb1eae44f6804bdcc628c7b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '69626cb9ef9687ce1c385774c29b5c1b7ad2ce870178d2db05db8cbcfc374094',
     armv7l: '69626cb9ef9687ce1c385774c29b5c1b7ad2ce870178d2db05db8cbcfc374094',
     x86_64: '2d730562402dad23a0da898caac2dd568ff563b25651cf1ae3bb454ab6f49203'
  })

  depends_on 'cairo' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'libharu' => :library
  depends_on 'libice' => :library
  depends_on 'libsm' => :library
  depends_on 'libx11' => :library
  depends_on 'libxext' => :library
  depends_on 'lua' => :library
  depends_on 'ocaml' => :library
  depends_on 'pango' => :library
  depends_on 'qhull' => :library
  depends_on 'swig' => :library
  depends_on 'wxwidgets' => :library

  no_fhs

  cmake_options '-DBUILD_TEST=ON \
    -DENABLE_DYNDRIVERS=OFF \
    -DENABLE_java=OFF \
    -DENABLE_qt=OFF \
    -DENABLE_tcl=OFF \
    -DUSE_INCRTCL_VERSION_4=ON'
end
