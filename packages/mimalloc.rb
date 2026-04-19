require 'buildsystems/cmake'

class Mimalloc < CMake
  description 'General-purpose allocator with excellent performance characteristics'
  homepage 'https://github.com/microsoft/mimalloc'
  version '3.3.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/mimalloc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd23db777d6a4c8d6cb8df6df74de73fc0f877fd55c9286190fa101677f4c526c',
     armv7l: 'd23db777d6a4c8d6cb8df6df74de73fc0f877fd55c9286190fa101677f4c526c',
       i686: '5ca518fb461f58a2221cb972b351338a3e32c869125a53c3d53a2166a4476fce',
     x86_64: '10de64314a001a19bd9150b4ced89639d726186f9ce7b3f4ccc1dbabebfc15ec'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library

  cmake_options '-DMI_BUILD_TESTS=OFF'
end
