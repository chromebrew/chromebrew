require 'buildsystems/cmake'

class Libfrei0r < CMake
  description 'Minimalistic API for a collection of free video effect plugins.'
  homepage 'https://frei0r.dyne.org/'
  version '3.2.0'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/dyne/frei0r.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a413f9f7cae1812308140e08ddde9bc1ff638843a7146f32165f3a57fe9d4215',
     armv7l: 'a413f9f7cae1812308140e08ddde9bc1ff638843a7146f32165f3a57fe9d4215',
     x86_64: '7434fefd8ad7cfdc82dbaceda6283ea16e7f8304e1340171fcbf121f2b70c3bd'
  })

  depends_on 'cairo' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'harfbuzz' => :library

  # TODO: should we add gavl and enable this?
  cmake_options '-DWITHOUT_OPENCV=ON -DWITHOUT_GAVL=ON'
end
