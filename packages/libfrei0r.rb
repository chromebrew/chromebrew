require 'buildsystems/cmake'

class Libfrei0r < CMake
  description 'Minimalistic API for a collection of free video effect plugins.'
  homepage 'https://frei0r.dyne.org/'
  version '3.2.1'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/dyne/frei0r.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd803ea454f7ca0c29a04887c4eed81072584820eb38db1c2bd855683a0e78bc6',
     armv7l: 'd803ea454f7ca0c29a04887c4eed81072584820eb38db1c2bd855683a0e78bc6',
     x86_64: '796498943d29c71c7efb337be8e2152f809e73406c42421d56b2cca99e94f8d5'
  })

  depends_on 'cairo' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'harfbuzz' => :library

  # TODO: should we add gavl and enable this?
  cmake_options '-DWITHOUT_OPENCV=ON -DWITHOUT_GAVL=ON'
end
