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
    aarch64: '97c9b292c699a6a595085e9c271142520a162ecb917b09063fbb1eec55d7b328',
     armv7l: '97c9b292c699a6a595085e9c271142520a162ecb917b09063fbb1eec55d7b328',
     x86_64: '33acc9967300b85bb92c80bcbcf0d060c9207df16fc1ba816ddf67247512fd27'
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
