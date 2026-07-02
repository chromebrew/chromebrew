require 'buildsystems/cmake'

class Jansson < CMake
  description 'Jansson is a C library for encoding, decoding and manipulating JSON data.'
  homepage 'https://github.com/akheron/jansson'
  version '2.15.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/akheron/jansson.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e059c436d0a53c7f8497631ad4aab8d880b2eb22c60ecf1d226d324e9b258cac',
     armv7l: 'e059c436d0a53c7f8497631ad4aab8d880b2eb22c60ecf1d226d324e9b258cac',
       i686: '4a99120991e0ba64987e0452a8293d150a53e7b93dfde06c9fd3803da294df94',
     x86_64: '97b712693d1c024144a355feacf7d22266a6384ac4920bf12e15cdfdc57a3061'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DJANSSON_BUILD_DOCS=OFF -DJANSSON_BUILD_SHARED_LIBS=ON'

  cmake_install_extras do
    # Unfortunately, there is no -DLIB_SUFFIX configure option.
    if ARCH.eql?('x86_64')
      FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
      FileUtils.mv Dir["#{CREW_DEST_PREFIX}/lib/*"], CREW_DEST_LIB_PREFIX
    end
  end
end
