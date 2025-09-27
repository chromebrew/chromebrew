require 'buildsystems/cmake'

class Libexiv2 < CMake
  description 'Exiv2 is a Cross-platform C++ library and a command line utility to manage image metadata.'
  homepage 'https://exiv2.org/'
  version '0.28.7'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/Exiv2/exiv2.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '576d3afdde6ec5beee77949fc136e4e1dead071759c3438ddd6267f8b825f12c',
     armv7l: '576d3afdde6ec5beee77949fc136e4e1dead071759c3438ddd6267f8b825f12c',
       i686: '78c9c06f3a70703feaf58bab95600d1418c3c548e8cdd6a200eddbea003591a5',
     x86_64: '4e19af118a55638584dc95c91a671db2c3dd3a6954ae3a4e577b7c12dd69b76a'
  })

  depends_on 'brotli' # R
  depends_on 'curl' # R
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libinih' # R
  depends_on 'zlib' # R

  def self.patch
    system "sed -i 's/MINGW OR CYGWIN OR CMAKE_HOST_SOLARIS/UNIX/g' cmake/compilerFlags.cmake"
  end

  cmake_options '-DEXIV2_ENABLE_CURL=ON \
      -DEXIV2_ENABLE_WEBREADY=ON \
      -DEXIV2_ENABLE_VIDEO=ON'
end
