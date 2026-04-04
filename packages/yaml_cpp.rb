require 'buildsystems/cmake'

class Yaml_cpp < CMake
  description 'A YAML parser and emitter in C++'
  homepage 'https://github.com/jbeder/yaml-cpp'
  version '0.9.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jbeder/yaml-cpp.git'
  git_hashtag "yaml-cpp-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0a658ec4b90fe259a863944ac87025402458e6735e4b9f7c2bf662fd3db7abb2',
     armv7l: '0a658ec4b90fe259a863944ac87025402458e6735e4b9f7c2bf662fd3db7abb2',
       i686: '2eb0c207fc2796def012c09e6430549e65fbe97c786158cf834e7a18a09e1d81',
     x86_64: 'd9d2286f669ef6fd0adcc9756bfcfe42194cf45bdd344f539700a9c00a487565'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
