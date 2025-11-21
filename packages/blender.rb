require 'buildsystems/cmake'

class Blender < CMake
  description 'Blender is the free and open source 3D creation suite.'
  homepage 'https://www.blender.org'
  version '5.0.0'
  license 'GPLv3+'
  compatibility 'x86_64'
  source_url "https://download.blender.org/source/blender-#{version}.tar.xz"
  source_sha256 '120b45227b1dba2ecec116c6f924f3e7efabebac762e030552fdf70baff1b5b4'
  binary_compression 'tar.zst'

  binary_sha256({
    x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'audaspace'
  depends_on 'boost' # R
  depends_on 'eigen'
  depends_on 'embree'
  depends_on 'ffmpeg'
  depends_on 'freetype'
  depends_on 'gmp' # R
  depends_on 'jack' # R
  depends_on 'libepoxy'
  depends_on 'libjpeg_turbo'
  depends_on 'libpng'
  depends_on 'libsndfile' # R
  depends_on 'libtiff'
  depends_on 'libwebp' # R
  depends_on 'libx11' # R
  depends_on 'libxfixes' # R
  depends_on 'libxi' # R
  depends_on 'libxkbcommon' # R
  depends_on 'libxrender' # R
  depends_on 'libxxf86vm' # R
  depends_on 'openal' # R
  depends_on 'openexr' # R
  depends_on 'openimageio'
  depends_on 'openjpeg' # R
  depends_on 'pipewire' # R
  depends_on 'pugixml' # R
  depends_on 'pulseaudio' # R
  depends_on 'py3_numpy'
  depends_on 'py3_requests'
  depends_on 'python3'
  depends_on 'sdl2' # R
  depends_on 'shaderc'
  depends_on 'tbb' # R
  depends_on 'vulkan_headers'
  depends_on 'zlib'
  depends_on 'zstd'

  cmake_options '-DWITH_FFTW3=OFF -DWITH_SYSTEM_EIGEN3=ON -DWITH_SYSTEM_AUDASPACE=ON -DPYTHON_VERSION=3.13 -DWITH_PYTHON_INSTALL=OFF -DWITH_INSTALL_PORTABLE=OFF'
end
