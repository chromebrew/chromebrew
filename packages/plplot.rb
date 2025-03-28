require 'buildsystems/cmake'

class Plplot < CMake
  description 'PLplot is a cross-platform software package for creating scientific plots'
  homepage 'https://plplot.sourceforge.net/'
  version '5.15.0'
  license 'LGPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://downloads.sourceforge.net/project/plplot/plplot/5.15.0%20Source/plplot-5.15.0.tar.gz'
  source_sha256 'b92de4d8f626a9b20c84fc94f4f6a9976edd76e33fb1eae44f6804bdcc628c7b'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '13f6b739b87349e98ec82b542d0bce70b982f76b7e72ede1ff22d8f020bc05d3',
     armv7l: '13f6b739b87349e98ec82b542d0bce70b982f76b7e72ede1ff22d8f020bc05d3',
     x86_64: '6aa2d9509f13283391d604ae0e3d9ff501f0ccf3a527ac0fe6e584d20d2f30a0'
  })

  depends_on 'libharu'
  depends_on 'lua'
  depends_on 'ocaml'
  depends_on 'openjdk8'
  depends_on 'pango'
  depends_on 'qhull'
  depends_on 'qt5_svg'
  depends_on 'swig'
  depends_on 'tk'
  depends_on 'wxwidgets'

  cmake_options '-DBUILD_TEST=ON -DENABLE_DYNDRIVERS=OFF -DUSE_INCRTCL_VERSION_4=ON'
end
