require 'buildsystems/cmake'

class Utfcpp < CMake
  description 'UTF-8 with C++ in a Portable Way'
  homepage 'https://github.com/nemtrif/utfcpp'
  version '4.0.6'
  license 'BSL-1.0'
  compatibility 'all'
  source_url 'https://github.com/nemtrif/utfcpp.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4d134a3722ed08f6131c157280bdce4d955cadac5d6e6e019abea7ccadeef7af',
     armv7l: '4d134a3722ed08f6131c157280bdce4d955cadac5d6e6e019abea7ccadeef7af',
       i686: 'b3f13129e261b233996539211665eebed157f4d6b06c41059ae8a706f578e202',
     x86_64: '0d1816a2714b26dac3a854f128cd5f10a289aaf4ff5c6159eed95ffe591641bc'
  })
end
