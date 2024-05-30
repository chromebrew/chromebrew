require 'buildsystems/cmake'

class Xzutils < CMake
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'https://tukaani.org/xz/'
  version '5.6.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/tukaani-project/xz.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '22591f4e76a127757ab32a76f9824b2cd0255070bd0e947f0893b650cf1f7891',
     armv7l: '22591f4e76a127757ab32a76f9824b2cd0255070bd0e947f0893b650cf1f7891',
       i686: '1a34b78c7a936eb1bbe76893382445d30daabe7dfd5e74af9d1513b2bee8e02f',
     x86_64: '994b58fa715a6cc852269b9b46f21ffc0d90f608f6ae4e5dc61272054ef471ae'
  })

  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
