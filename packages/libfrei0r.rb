require 'buildsystems/cmake'

class Libfrei0r < CMake
  description 'Minimalistic API for a collection of free video effect plugins.'
  homepage 'https://frei0r.dyne.org/'
  version '2.5.4'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/dyne/frei0r.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7acedb2d0e857f529ce5e36aadf923b89674ffc2da37bd412f07e24acd8308ce',
     armv7l: '7acedb2d0e857f529ce5e36aadf923b89674ffc2da37bd412f07e24acd8308ce',
     x86_64: '8c546108bd074c5023b9068d7a83da6564028ca31cb9dba7ed6fbf007554c808'
  })

  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R

  # TODO: should we add gavl and enable this?
  cmake_options '-DWITHOUT_OPENCV=ON -DWITHOUT_GAVL=ON'
end
