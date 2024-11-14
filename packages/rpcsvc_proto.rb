require 'buildsystems/autotools'

class Rpcsvc_proto < Autotools
  description 'rpcsvc protocol definitions from glibc'
  homepage 'https://github.com/thkukuk/rpcsvc-proto'
  version '1.4.4-1'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/thkukuk/rpcsvc-proto.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b80f415e923ea6ab32490b069a19c6a6bd78e2c45b7abb0f97e451c52ad9ff49',
     armv7l: 'b80f415e923ea6ab32490b069a19c6a6bd78e2c45b7abb0f97e451c52ad9ff49',
       i686: '39fd2d0e9d1066c1a35569b831b9ddd8cf51c28eef4b9e56fd08dfb43790406c',
     x86_64: '39e69c11f4adb6b7aa2e4f4f894a40a49e430f66db4b383b569041555d3e9d37'
  })
end
