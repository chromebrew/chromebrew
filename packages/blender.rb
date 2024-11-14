require 'buildsystems/cmake'

class Blender < CMake
  description 'Blender is the free and open source 3D creation suite.'
  homepage 'https://www.blender.org'
  version '4.1.1'
  license 'GPLv3+'
  compatibility 'x86_64'
  source_url 'https://download.blender.org/source/blender-4.1.1.tar.xz'
  source_sha256 '4fbb3af64d3f84df5c7103748454226c1885c1ac2ed5373d0cea1e80e82c0848'
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '1785f34e092a4c359f003b6bf70ae1a39c8b06eb9f4a89aa9b729e1893bfc4e4'
  })

  # depends_on 'audaspace'
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
  depends_on 'libsdl2' # R
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
  depends_on 'tbb' # R
  depends_on 'zlib'
  depends_on 'zstd'

  def self.patch
    # These fixes haven't made their way to a release yet, so we just patch them in.
    # [PATCH] Use set_and_warn_dependency to disable WITH_MOD_OCEANSIM if WITH_FFTW3 is disabled.
    downloader 'https://projects.blender.org/blender/blender/commit/0a74065a1995ef5423b3e073f53328d664b43b05.patch', '8a2f9739c716822a94c94894cf32b4ed8d87809b38a8c53d6288f5f2ce8490f1'
    system 'patch -Np1 -i 0a74065a1995ef5423b3e073f53328d664b43b05.patch'
    # [PATCH] Unbreak lite-build WITH_GMP enabled
    downloader 'https://projects.blender.org/blender/blender/commit/861536b24c866d09857ea4b92717f822da4bc75e.patch', 'c7b6560da9062aa984aba3b67212d4694cbd3ec4a72dc6cae3b3d01a43ed0b5a'
    system 'patch -Np1 -i 861536b24c866d09857ea4b92717f822da4bc75e.patch'
  end

  # Blender needs the single-precision build of fftw, which we do not provide.
  # WITH_SYSTEM_AUDASPACE is broken in 4.1.1, should be resolved in 4.2
  # WITH_INSTALL_PORTABLE needs to be disabled to get a a FHS-compatible install.
  cmake_options '-DWITH_FFTW3=OFF -DWITH_SYSTEM_EIGEN3=ON -DPYTHON_VERSION=3.12 -DWITH_PYTHON_INSTALL=OFF -DWITH_INSTALL_PORTABLE=OFF'
end
