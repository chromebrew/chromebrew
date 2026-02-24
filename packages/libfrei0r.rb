require 'buildsystems/cmake'

class Libfrei0r < CMake
  description 'Minimalistic API for a collection of free video effect plugins.'
  homepage 'https://frei0r.dyne.org/'
  version '2.5.1'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/dyne/frei0r.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a6f6053dd096606bfd9bf3375bf3092c2487b895ba0ee822e5dc44d4a07dfc8d',
     armv7l: 'a6f6053dd096606bfd9bf3375bf3092c2487b895ba0ee822e5dc44d4a07dfc8d',
     x86_64: 'c7c8ed067dfb67fb7f908879841f05e5e5dbd3fc8847dfbfb7453b1b14dd4329'
  })

  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R

  cmake_options "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_CXX_FLAGS=' -L#{CREW_LIB_PREFIX}'"
end
