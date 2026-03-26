require 'buildsystems/cmake'

class Srt < CMake
  description 'Secure Reliable Transport library'
  homepage 'https://www.srtalliance.org/'
  version '1.5.4'
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/Haivision/srt.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9e4829a5c40b77541fd49e535803e5d739766c4f353886973931662fb93ca068',
     armv7l: '9e4829a5c40b77541fd49e535803e5d739766c4f353886973931662fb93ca068',
       i686: '752e5c3e998a25789dfec3a7e124c8a2c2bc6eefbea20b4ed8e386dd802a6068',
     x86_64: '9845a7019d93b2cd927e7d458882bbccaa54fad191bf7ddacd20084acc5d051b'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'openssl' => :library

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5'
end
