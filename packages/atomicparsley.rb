require 'buildsystems/cmake'

class Atomicparsley < CMake
  description 'AtomicParsley is a lightweight command line program for reading, parsing and setting metadata into MPEG-4 files, in particular, iTunes-style metadata.'
  homepage 'https://github.com/wez/atomicparsley'
  version '20240608.083822.1ed9031'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/wez/atomicparsley.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '98bb6f0ae44ce6b31a50f61192745b775201de9bccdaadf19c449779e9ebf559',
     armv7l: '98bb6f0ae44ce6b31a50f61192745b775201de9bccdaadf19c449779e9ebf559',
       i686: '81af4eadadd00e38943bbfc33aac035b5e48ae1b59e6f3e91890cfb5bfd788d9',
     x86_64: '47f74b668693dcb2794b093aeda17fd90300ab4647bebab871e3e48835b7694a'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zlib' # R
end
