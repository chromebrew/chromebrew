require 'buildsystems/cmake'

class Taglib < CMake
  description 'TagLib is a library for reading and editing the meta-data of several popular audio formats.'
  homepage 'https://taglib.org'
  version '2.2.1'
  license 'LGPL-2.1 and MPL-1.1'
  compatibility 'all'
  source_url "https://taglib.org/releases/taglib-#{version}.tar.gz"
  source_sha256 '7e76b5299dcef427c486bffe455098470c8da91cf3ccb9ea804893df57389b5e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5e7c62cd76eb51e7e72e9ca2a51222f25d1ba0162279819c1bb217b8e3c1b682',
     armv7l: '5e7c62cd76eb51e7e72e9ca2a51222f25d1ba0162279819c1bb217b8e3c1b682',
       i686: '899332f0dd2d8c962fe8aa97af7cab8dda83ce131ae5f141fe9acf73e209e007',
     x86_64: 'edda8b6900ca4bc2f56ebe0ab784596afbc8b77edc1a8540e8810c276df349c3'
  })

  depends_on 'boost' => :build
  depends_on 'cppunit' => :build
  depends_on 'utfcpp'
end
