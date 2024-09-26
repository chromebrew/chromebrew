require 'buildsystems/cmake'

class Openimageio < CMake
  description 'OpenImageIO is a toolset for reading, writing, and manipulating image files of any image file format relevant to VFX / animation via a format-agnostic API with a feature set, scalability, and robustness needed for feature film production.'
  homepage 'https://github.com/AcademySoftwareFoundation/OpenImageIO'
  version "2.5.15.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/AcademySoftwareFoundation/OpenImageIO.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f6ff0c84c8844183e2b49fa214daa451c6515a5d1e6ae1dcb70ebe6d94c02ef8',
     armv7l: 'f6ff0c84c8844183e2b49fa214daa451c6515a5d1e6ae1dcb70ebe6d94c02ef8',
     x86_64: '44955202370b6691ff0fd388dfb96863adad55ec4f720e0caef2356815c0e343'
  })

  depends_on 'boost'
  depends_on 'bzip2' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'giflib' # R
  depends_on 'libfmt'
  depends_on 'libjpeg_turbo'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libwebp' # R
  depends_on 'openexr'
  depends_on 'pugixml'
  depends_on 'py3_pybind11'
  depends_on 'zlib' # R

  # The setup for finding pybind11 is custom, so it's hard to tell where exactly it breaks to fix it properly.
  cmake_options "-Dpybind11_ROOT=#{CREW_PREFIX}/lib/python#{version.split('y').last}/site-packages/pybind11 -DOIIO_BUILD_TESTS=OFF"
end
