require 'buildsystems/cmake'

class Utfcpp < CMake
  description 'UTF-8 with C++ in a Portable Way'
  homepage 'https://github.com/nemtrif/utfcpp'
  version '4.2.1'
  license 'BSL-1.0'
  compatibility 'all'
  source_url 'https://github.com/nemtrif/utfcpp.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8c1dd337fa23c7223a53768f6b8e9a441535608fe7f2fee90f08677ef4f3f31f',
     armv7l: '8c1dd337fa23c7223a53768f6b8e9a441535608fe7f2fee90f08677ef4f3f31f',
       i686: '020d30fc3824bc7b1500c731aaf3765155f82cf4631fd1b108db4ca5c4a036ac',
     x86_64: 'f1d5d69fef3b1a2b7195a3cca9e7028c4f67ce6b3b5b9862c90adb6ab2b850a3'
  })
end
