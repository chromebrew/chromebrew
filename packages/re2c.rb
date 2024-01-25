require 'buildsystems/cmake'

class Re2c < CMake
  description 're2c is a free and open-source lexer generator for C and C++.'
  homepage 'http://re2c.org/'
  version '3.1'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/skvadrik/re2c/releases/download/3.1/re2c-3.1.tar.lz'
  source_sha256 '1c499e89ffd9926d79374fa5101c27a4bc89355462d5217abdbe4c76312db2f1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'de01cccbde508b8f13ea0100c6b87aa640087865849b56bc78f55da9973437bc',
     armv7l: 'de01cccbde508b8f13ea0100c6b87aa640087865849b56bc78f55da9973437bc',
       i686: '7a920a06ca30f757003f3199e070a9a7c33a250d053bd35d55c6c2e4e266285a',
     x86_64: '765e292a2ad73ed9ca4704b72ee4163f3644071bf6727005e32a21349e9873d2'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
