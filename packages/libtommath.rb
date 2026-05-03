require 'buildsystems/cmake'

class Libtommath < CMake
  description 'LibTomMath is a free open source portable number theoretic multiple-precision integer library written entirely in C.'
  homepage 'https://www.libtom.net/'
  version '1.3.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libtom/libtommath.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7f6339ca083956c06ae62710e486cdb49a9fb9d5448ca1332fea57fe0d29a029',
     armv7l: '7f6339ca083956c06ae62710e486cdb49a9fb9d5448ca1332fea57fe0d29a029',
       i686: '3f3972ee14f7d38953afe50f6b5889cabad4e532264df79ab47c83ce62775874',
     x86_64: '38e6c521776e089729a29b43dbb24e142614edb7e88e077cc69f81dbe0136ff7'
  })
end
