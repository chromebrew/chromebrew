require 'buildsystems/cmake'

class Libfrei0r < CMake
  description 'Minimalistic API for a collection of free video effect plugins.'
  homepage 'https://frei0r.dyne.org/'
  version '3.1.1'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/dyne/frei0r.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a8e4462007b9b71e0b60cc1986e01e966af0fd955b1d29df18224a1bc9491d53',
     armv7l: 'a8e4462007b9b71e0b60cc1986e01e966af0fd955b1d29df18224a1bc9491d53',
     x86_64: '896e86e06f59db104987e47ccf5a3fc3af1039a21ba299e236f10410e15845c6'
  })

  depends_on 'cairo' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'harfbuzz' => :library

  # TODO: should we add gavl and enable this?
  cmake_options '-DWITHOUT_OPENCV=ON -DWITHOUT_GAVL=ON'
end
