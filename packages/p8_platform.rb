require 'buildsystems/cmake'

class P8_platform < CMake
  description 'Platform support library used by libCEC and binary add-ons for Kodi'
  homepage 'https://github.com/Pulse-Eight/platform'
  version '8-platform-2.2.0'
  license 'GPL'
  compatibility 'all'
  source_url 'https://github.com/Pulse-Eight/platform.git'
  git_hashtag "p8-platform-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '850f3531ebd519bf1ecb9de246e3c489e0d6a6534d6a820118dc49da561aee34',
     armv7l: '850f3531ebd519bf1ecb9de246e3c489e0d6a6534d6a820118dc49da561aee34',
       i686: '84b11d4faef4fad6079bf6675ebf9fe97c3cf67efa0f784e315e4759ec83e84d',
     x86_64: 'c551868cab7f6ea49e7ea48b5858984591e158d722ab088858c46866342c7ff2'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
