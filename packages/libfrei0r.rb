require 'buildsystems/cmake'

class Libfrei0r < CMake
  description 'Minimalistic API for a collection of free video effect plugins.'
  homepage 'https://frei0r.dyne.org/'
  version '2.5.6'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/dyne/frei0r.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1501a40474325902aa103b712eca13253e3ffe817ffe15c7fc91dbe965a707c1',
     armv7l: '1501a40474325902aa103b712eca13253e3ffe817ffe15c7fc91dbe965a707c1',
     x86_64: '04b4c16da5480d35cc4268e5cde4c4cb038f22aaaca05cea6f290f6d4045c56f'
  })

  depends_on 'cairo' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'harfbuzz' => :library

  # TODO: should we add gavl and enable this?
  cmake_options '-DWITHOUT_OPENCV=ON -DWITHOUT_GAVL=ON'
end
