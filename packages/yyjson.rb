require 'buildsystems/cmake'

class Yyjson < CMake
  description 'A high performance JSON library written in ANSI C'
  homepage 'https://ibireme.github.io/yyjson'
  version '0.13.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ibireme/yyjson.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eb353952f67a8ea86e8522ba07a9594a20c707c6fa66faebd6aeacbaf4405ab7',
     armv7l: 'eb353952f67a8ea86e8522ba07a9594a20c707c6fa66faebd6aeacbaf4405ab7',
       i686: 'b8fcabc5f6f6fa33b351f84616a4a33180d91e0096bfa47341e222fc5ab37ef6',
     x86_64: '0dfc843ba6189ff081f6a345669cd6bc93f5ae819541f225352aae827955fcbb'
  })

  depends_on 'glibc' => :library

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
