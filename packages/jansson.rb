require 'buildsystems/cmake'

class Jansson < CMake
  description 'Jansson is a C library for encoding, decoding and manipulating JSON data.'
  homepage 'https://github.com/akheron/jansson'
  version '2.15.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/akheron/jansson.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b6685abaaae6a1ca5bebce3ad71a57b00fcd14be195c941867b0b197cb8763e5',
     armv7l: 'b6685abaaae6a1ca5bebce3ad71a57b00fcd14be195c941867b0b197cb8763e5',
       i686: 'f5d42b40e698f39bd6fb23321abb6be141f276bdf2284d1fc87a8b103b0cefed',
     x86_64: 'c2d4025f913d9c01ffbb494ba7da737eab8f661636f00c696202d587a4a6c8c6'
  })

  depends_on 'glibc' # R

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DJANSSON_BUILD_DOCS=OFF -DJANSSON_BUILD_SHARED_LIBS=ON'

  cmake_install_extras do
    # Unfortunately, there is no -DLIB_SUFFIX configure option.
    if ARCH.eql?('x86_64')
      FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
      FileUtils.mv Dir["#{CREW_DEST_PREFIX}/lib/*"], CREW_DEST_LIB_PREFIX
    end
  end
end
