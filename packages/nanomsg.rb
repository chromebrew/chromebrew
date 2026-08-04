require 'buildsystems/cmake'

class Nanomsg < CMake
  description 'nanomsg is a socket library that provides several common communication patterns.'
  homepage 'https://nanomsg.org/'
  version '1.2.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nanomsg/nanomsg.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '959be69b396318a6b69e9170ca1cd166e05c5480490d1ed1357905f593e481d0',
     armv7l: '959be69b396318a6b69e9170ca1cd166e05c5480490d1ed1357905f593e481d0',
       i686: '0934bf25c9903ab29ab5a150dba44c664c2095883ffd1d03d0df5d4168526017',
     x86_64: 'a44e5074d28628eabfae9f3ca01fe2e64391e161a7af628896ba201547b4f601'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  run_tests
end
