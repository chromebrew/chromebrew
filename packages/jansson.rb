require 'buildsystems/cmake'

class Jansson < CMake
  description 'Jansson is a C library for encoding, decoding and manipulating JSON data.'
  homepage 'https://github.com/akheron/jansson'
  version '2.14.1-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/akheron/jansson.git'
  git_hashtag "v#{version.split('-')[0]}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aafccf57e3f8e28b720dedd2ce3b919874caaef1cc048de8e4997a0e82e980ca',
     armv7l: 'aafccf57e3f8e28b720dedd2ce3b919874caaef1cc048de8e4997a0e82e980ca',
       i686: '17d0fce402ba1eb72c150f599e0844b51b1822f07b7dfcc013d02df1fe2a87f4',
     x86_64: 'a8a588fa0215143177a515a40ef3c61eca362081925037a734367a4b82d38b74'
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
