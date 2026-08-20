require 'buildsystems/cmake'

class Extra_cmake_modules < CMake
  description 'Extra modules and scripts for CMake.'
  homepage 'https://invent.kde.org/frameworks/extra-cmake-modules'
  version '6.29.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://invent.kde.org/frameworks/extra-cmake-modules.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b39ce559e777a37b923031d6a6cf1102fd148d0e84bf404573b27964c15ab1ec',
     armv7l: 'b39ce559e777a37b923031d6a6cf1102fd148d0e84bf404573b27964c15ab1ec',
       i686: '1b989137863b80e982141fdbced9ff26fe245bca7c3a286a10c9c80d783580e9',
     x86_64: '7e58b6f9fff6e0744b37c0e8b4a65664c32e454afa31aa13a587e977968a0ec1'
  })

  depends_on 'sphinx' => :build
end
