require 'buildsystems/cmake'

class Srt < CMake
  description 'Secure Reliable Transport library'
  homepage 'https://www.srtalliance.org/'
  version '1.5.5'
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/Haivision/srt.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2a6b5a823f2c28169b5ba18a9b67588cfc6dbde71773df8464f6ae343135d4cf',
     armv7l: '2a6b5a823f2c28169b5ba18a9b67588cfc6dbde71773df8464f6ae343135d4cf',
       i686: 'aff9ef9332424d81b029a99ad58ea84d9eed59260c4b0bdb011b886622ccc85f',
     x86_64: 'c54606ca2102cb6df5f83ee4aa29595807cf34b7219f71a7735a28bd5a5b4fd4'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'openssl' => :library

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5'
end
