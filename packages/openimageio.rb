require 'buildsystems/cmake'

class Openimageio < CMake
  description 'OpenImageIO is a toolset for reading, writing, and manipulating image files of any image file format relevant to VFX / animation via a format-agnostic API with a feature set, scalability, and robustness needed for feature film production.'
  homepage 'https://github.com/AcademySoftwareFoundation/OpenImageIO'
  version '2.5.12.0-py3.12'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/AcademySoftwareFoundation/OpenImageIO.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '293f193c4c9bd02dae17d5b2f6fe68925f804e5a2e67bf1a2344c1fb80df1a2b',
     armv7l: '293f193c4c9bd02dae17d5b2f6fe68925f804e5a2e67bf1a2344c1fb80df1a2b',
     x86_64: 'c5bc2ce8a7ff1e45ff7e8c4e1e5a573a61e10d56ed71c929173e9758213da339'
  })

  depends_on 'boost'
  depends_on 'bzip2' # R
  depends_on 'freetype' # R
  depends_on 'giflib' # R
  depends_on 'libfmt'
  depends_on 'libjpeg_turbo'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libwebp' # R
  depends_on 'openexr'
  depends_on 'pugixml'
  depends_on 'py3_pybind11'
  depends_on 'zlibpkg' # R

  # The setup for finding pybind11 is custom, so it's hard to tell where exactly it breaks to fix it properly.
  cmake_options "-Dpybind11_ROOT=#{CREW_PREFIX}/lib/python#{version.split('y').last}/site-packages/pybind11 -DOIIO_BUILD_TESTS=OFF"
end
