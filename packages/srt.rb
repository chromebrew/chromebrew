require 'buildsystems/cmake'

class Srt < CMake
  description 'Secure Reliable Transport library'
  homepage 'https://www.srtalliance.org/'
  version '1.5.7'
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/Haivision/srt.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8105c8892998dc80b0d5de85cc70cf0c911272e97750533a06acf58f2b687ce4',
     armv7l: '8105c8892998dc80b0d5de85cc70cf0c911272e97750533a06acf58f2b687ce4',
       i686: '7065d338630488b9a42eaffef7d6a930b53400602cc18708571504c7b9eac79e',
     x86_64: 'b774502089e248cb373d8ec43aa98f335609d86b920232533f25af438440fa9e'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl' => :library

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5'
end
