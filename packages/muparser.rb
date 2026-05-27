require 'buildsystems/cmake'

class Muparser < CMake
  description 'muParser is an extensible high performance math expression parser library written in C++.'
  homepage 'https://beltoforion.de/article.php?a=muparser'
  version '2.3.5'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/beltoforion/muparser.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f97418183d4797ba6ea12f805eae482a096985a7deecfb6f78fa3c25a176f656',
     armv7l: 'f97418183d4797ba6ea12f805eae482a096985a7deecfb6f78fa3c25a176f656',
       i686: '0904571afb0b115b965d64f076b8e24b1bf22e031641fa5d75c6ee7d41f84fdd',
     x86_64: 'e0070df94f04d25c19b20eb00f1e83f3be8a551b3e7f77ca162aceedfcce171a'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openmp' => :library

  cmake_options '-DENABLE_WIDE_CHAR=ON -DENABLE_SAMPLES=OFF'
end
