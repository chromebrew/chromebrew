require 'buildsystems/cmake'

class Libfrei0r < CMake
  description 'Minimalistic API for a collection of free video effect plugins.'
  homepage 'https://frei0r.dyne.org/'
  version '3.7.0'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/dyne/frei0r.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3fb92ddaaa1b0b8cbad6e395835ca9adb23441e7d02a382d7add314c1a530c24',
     armv7l: '3fb92ddaaa1b0b8cbad6e395835ca9adb23441e7d02a382d7add314c1a530c24',
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
