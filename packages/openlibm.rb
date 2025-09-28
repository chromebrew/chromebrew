require 'buildsystems/cmake'

class Openlibm < CMake
  description 'A high quality system independent, portable, open source libm implementation'
  homepage 'https://openlibm.org/'
  version '0.8.7'
  license 'public-domain, MIT, ISC, BSD-2 and LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/JuliaMath/openlibm.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6fe9711adced35e1553d459391336d3533191423cf7022254c944fb396a5f8eb',
     armv7l: '6fe9711adced35e1553d459391336d3533191423cf7022254c944fb396a5f8eb',
       i686: 'ed101fca3084ad91ed31731c5712ecd6db64d1e52032623eabadbcae02085b31',
     x86_64: '6b7eb77d7dd988c3a41d738612a33068629bf6fd96fb28af62083f37395f7680'
  })

  def self.patch
    system "sed -i 's/elseif(${OPENLIBM_ARCH_FOLDER} STREQUAL \"armv7-a\")/elseif(${OPENLIBM_ARCH_FOLDER} STREQUAL \"armv7-a\" OR ${OPENLIBM_ARCH_FOLDER} STREQUAL \"armv7l\" OR ${OPENLIBM_ARCH_FOLDER} STREQUAL \"armv8l\")/' CMakeLists.txt"
  end
end
