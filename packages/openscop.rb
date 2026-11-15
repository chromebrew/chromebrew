require 'buildsystems/autotools'

class Openscop < Autotools
  description 'OpenScop is a Specification and a Library for Data Exchange in Polyhedral Compilation Tools'
  homepage 'https://github.com/periscop/openscop'
  version '0.9.8'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/periscop/openscop.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '65da894be9fc9c447150ccae062787c8ef2116d74ff884552a74aabeb84b2ef1',
     armv7l: '65da894be9fc9c447150ccae062787c8ef2116d74ff884552a74aabeb84b2ef1',
       i686: '955c0a4f172b5164715d6c346e01c64d5b06930f1b14b7ff1177e1e52781ec86',
     x86_64: 'f1521b8b03d24c3278abe77e228fc8dfbefb12a7df9851aeb090ffe43f617905'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :library

  run_tests
end
