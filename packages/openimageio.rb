require 'buildsystems/cmake'

class Openimageio < CMake
  description 'OpenImageIO is a toolset for reading, writing, and manipulating image files of any image file format relevant to VFX / animation via a format-agnostic API with a feature set, scalability, and robustness needed for feature film production.'
  homepage 'https://github.com/AcademySoftwareFoundation/OpenImageIO'
  version "2.5.15.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/AcademySoftwareFoundation/OpenImageIO.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '049b6ff44513d7ac59131ed90510a1bd75478bd97d6ff105ea885afd0fc604d0',
     armv7l: '049b6ff44513d7ac59131ed90510a1bd75478bd97d6ff105ea885afd0fc604d0',
     x86_64: 'be1c91b52f7e4704426073780b420965669f1008778c9175a732090aa51d0773'
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
  depends_on 'ffmpeg' # R
  depends_on 'openjpeg' # R

  # The setup for finding pybind11 is custom, so it's hard to tell where exactly it breaks to fix it properly.
  cmake_options "-Dpybind11_ROOT=#{CREW_PREFIX}/lib/python#{version.split('y').last}/site-packages/pybind11 -DOIIO_BUILD_TESTS=OFF"
end
