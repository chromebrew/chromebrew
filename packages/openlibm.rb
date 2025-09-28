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
    aarch64: '3c314f643ea1c940681fb6d504e397af0908235d9b2bce463351ffc47d064e80',
     armv7l: '3c314f643ea1c940681fb6d504e397af0908235d9b2bce463351ffc47d064e80',
       i686: '05fc93989659b621a63cb7846f0cec40b21afd72e82d5a495b6835ef2439bdea',
     x86_64: '874fa3a677169dc506eb3b24c52e2dafef433d4f34bacfb3e30696da8611bf64'
  })

  def self.patch
    system "sed -i 's/elseif(${OPENLIBM_ARCH_FOLDER} STREQUAL \"armv7-a\")/elseif(${OPENLIBM_ARCH_FOLDER} STREQUAL \"armv7-a\" OR ${OPENLIBM_ARCH_FOLDER} STREQUAL \"armv7l\" OR ${OPENLIBM_ARCH_FOLDER} STREQUAL \"armv8l\")/' CMakeLists.txt"
  end
end
