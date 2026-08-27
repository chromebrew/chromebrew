require 'buildsystems/cmake'

class Libfrei0r < CMake
  description 'Minimalistic API for a collection of free video effect plugins.'
  homepage 'https://frei0r.dyne.org/'
  version '3.5.0'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/dyne/frei0r.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fbc82cd4444125a81703a536b3a5ad6ac6e26cf09cf19de3c7d23cca483f0994',
     armv7l: 'fbc82cd4444125a81703a536b3a5ad6ac6e26cf09cf19de3c7d23cca483f0994',
     x86_64: 'ff8452ef637aa119b030143c5112f7ed87c73421d0c8ea3c30ebfab67ad0ea78'
  })

  depends_on 'cairo' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'harfbuzz' => :library

  # TODO: should we add gavl and enable this?
  cmake_options '-DWITHOUT_OPENCV=ON -DWITHOUT_GAVL=ON'
end
