require 'buildsystems/cmake'

class Libfrei0r < CMake
  description 'Minimalistic API for a collection of free video effect plugins.'
  homepage 'https://frei0r.dyne.org/'
  version '3.7.1'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/dyne/frei0r.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd4bcd4b3dd8ebb2c688fe700867b088875298e3181e223ec4449bb8f5d8ceb1b',
     armv7l: 'd4bcd4b3dd8ebb2c688fe700867b088875298e3181e223ec4449bb8f5d8ceb1b',
     x86_64: '1008cf7744c8ec82139f9dc4665db29b9f6608f0696f105de897bcd6048e7c2d'
  })

  depends_on 'cairo' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'libglvnd' => :library

  # TODO: should we add gavl and enable this?
  cmake_options '-DWITHOUT_OPENCV=ON -DWITHOUT_GAVL=ON'
end
