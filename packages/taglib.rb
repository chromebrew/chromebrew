require 'buildsystems/cmake'

class Taglib < CMake
  description 'TagLib is a library for reading and editing the meta-data of several popular audio formats.'
  homepage 'https://taglib.org'
  version '2.1.1'
  license 'LGPL-2.1 and MPL-1.1'
  compatibility 'all'
  source_url "https://taglib.org/releases/taglib-#{version}.tar.gz"
  source_sha256 '0de288d7fe34ba133199fd8512f19cc1100196826eafcb67a33b224ec3a59737'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '523fad65ddd68a04cbda6b4b93184981d498d92fff777d3659ed733904e92f82',
     armv7l: '523fad65ddd68a04cbda6b4b93184981d498d92fff777d3659ed733904e92f82',
       i686: 'ad18cefa364f4ec60badde0ce4b57723822ce592eddd8b47699f96e085144225',
     x86_64: '88502332e2346e539fa019488622b44f3f3757e60a9c6bec9bcb64f2965f450b'
  })

  depends_on 'boost' => :build
  depends_on 'cppunit' => :build
  depends_on 'utfcpp'
end
