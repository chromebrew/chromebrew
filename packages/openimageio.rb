require 'buildsystems/cmake'

class Openimageio < CMake
  description 'OpenImageIO is a toolset for reading, writing, and manipulating image files of any image file format relevant to VFX / animation via a format-agnostic API with a feature set, scalability, and robustness needed for feature film production.'
  homepage 'https://github.com/AcademySoftwareFoundation/OpenImageIO'
  version "2.5.19.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/AcademySoftwareFoundation/OpenImageIO.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2e68b1099d5984634befce22c9cb760feded2bd4cfd16cc56d5975a475bdab7d',
     armv7l: '2e68b1099d5984634befce22c9cb760feded2bd4cfd16cc56d5975a475bdab7d',
     x86_64: '735eed27843f0658dd7f88cfffe17ba7a4e2f76661d1d517e8d8dfc0ed3c4ee2'
  })

  depends_on 'boost' => :library
  depends_on 'bzip2' => :library
  depends_on 'ffmpeg' => :library
  depends_on 'freetype' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'giflib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libfmt' => :library
  depends_on 'libglu' => :executable
  depends_on 'libglvnd' => :executable
  depends_on 'libheif' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libpng' => :library
  depends_on 'libtiff' => :library
  depends_on 'libwebp' => :library
  depends_on 'openexr' => :library
  depends_on 'openjpeg' => :library
  depends_on 'pugixml' => :library
  depends_on 'py3_pybind11' => :library
  depends_on 'qt5_base' => :executable
  depends_on 'zlib' => :library

  # The setup for finding pybind11 is custom, so it's hard to tell where exactly it breaks to fix it properly.
  cmake_options "-Dpybind11_ROOT=#{CREW_PREFIX}/lib/python#{version.split('y').last}/site-packages/pybind11 -DOIIO_BUILD_TESTS=OFF"
end
