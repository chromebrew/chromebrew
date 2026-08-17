require 'buildsystems/cmake'

class Libfrei0r < CMake
  description 'Minimalistic API for a collection of free video effect plugins.'
  homepage 'https://frei0r.dyne.org/'
  version '3.3.0'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/dyne/frei0r.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8f72c9a12741f3f4c3e6ee2c626d3ef62105afab39b6b7bff52a25b4ba2ea1bd',
     armv7l: '8f72c9a12741f3f4c3e6ee2c626d3ef62105afab39b6b7bff52a25b4ba2ea1bd',
     x86_64: '18af0115f1dbd93265e3a1b445468baf9883b9dc3eaa6d19cf8da4aa101c6534'
  })

  depends_on 'cairo' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'harfbuzz' => :library

  # TODO: should we add gavl and enable this?
  cmake_options '-DWITHOUT_OPENCV=ON -DWITHOUT_GAVL=ON'
end
