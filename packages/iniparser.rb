require 'buildsystems/cmake'

class Iniparser < CMake
  description 'stand-alone ini parser library in ANSI C'
  homepage 'http://ndevilla.free.fr/iniparser/'
  version '4.2.6'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ndevilla/iniparser.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '295fa27bf359fabf07a1ea8cd0471838521f1c30f8b282b52abac1cef78572a7',
     armv7l: '295fa27bf359fabf07a1ea8cd0471838521f1c30f8b282b52abac1cef78572a7',
       i686: '26aa6ee31d08fe36f526d81ebfec792f5af76141567430426ae15489caf1cb70',
     x86_64: '6888f3e699735c0e2699a01f55300aeae14bd1468977b69e3c7f098d350fe40b'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DBUILD_TESTING=ON'

  run_tests
end
