require 'buildsystems/cmake'

class Srt < CMake
  description 'Secure Reliable Transport library'
  homepage 'https://www.srtalliance.org/'
  version '1.5.6'
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/Haivision/srt.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0182636d7e6067709ed45f2daa4de3ae1db865b83cfb9659d04f55f0e50a58f5',
     armv7l: '0182636d7e6067709ed45f2daa4de3ae1db865b83cfb9659d04f55f0e50a58f5',
       i686: '9ff76b05eb8586d90bd840f16f852b6cd5b108784c96343594c4bb43aaab047d',
     x86_64: 'd10753984ec97a1636ceb03ef3b3cbd25d808366ea60473cfea13a067f241873'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'openssl' => :library

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5'
end
