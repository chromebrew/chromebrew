require 'buildsystems/cmake'

class Openlibm < CMake
  description 'A high quality system independent, portable, open source libm implementation'
  homepage 'https://openlibm.org/'
  version '0.8.8'
  license 'public-domain, MIT, ISC, BSD-2 and LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/JuliaMath/openlibm.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '93955c80c088cc6efcef359126e453dd74e8af9741234c7dc57085ff218f0ace',
     armv7l: '93955c80c088cc6efcef359126e453dd74e8af9741234c7dc57085ff218f0ace',
       i686: 'cc5a54a59dc00c410685442c4a125d688801ae87a46e46ffc87bc7a2bb1e7d81',
     x86_64: 'd3f8d29cbb3bf13b7bda8e2a2c909c52983126df16b2ac4cba48ca70b6b9fb94'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  def self.patch
    system "sed -i 's/elseif(${OPENLIBM_ARCH_FOLDER} STREQUAL \"armv7-a\")/elseif(${OPENLIBM_ARCH_FOLDER} STREQUAL \"armv7-a\" OR ${OPENLIBM_ARCH_FOLDER} STREQUAL \"armv7l\" OR ${OPENLIBM_ARCH_FOLDER} STREQUAL \"armv8l\")/' CMakeLists.txt"
  end
end
