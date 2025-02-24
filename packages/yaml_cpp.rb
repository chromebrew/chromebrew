require 'buildsystems/cmake'

class Yaml_cpp < CMake
  description 'A YAML parser and emitter in C++'
  homepage 'https://github.com/jbeder/yaml-cpp'
  version '0.8.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jbeder/yaml-cpp.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5bc7476e4cec2138d7812598842f35cc75dab5153484d40b0b733b203b61a72c',
     armv7l: '5bc7476e4cec2138d7812598842f35cc75dab5153484d40b0b733b203b61a72c',
       i686: 'a7dd7c6ae9b83a6c0c46a74bf1566ac748502fafc9747dae05392e82f5497a1d',
     x86_64: '9aa2f68e52ffda021f36b8df9bb5b6f4907ecc200e86cda819b2d985e6b8b4c3'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
