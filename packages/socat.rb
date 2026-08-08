require 'buildsystems/autotools'

class Socat < Autotools
  description 'SOcket CAT is a multipurpose relay \'netcat++\' (extended design, new implementation).'
  homepage 'http://www.dest-unreach.org/socat/'
  version '1.8.1.3'
  license 'GPL-2'
  compatibility 'all'
  source_url "http://www.dest-unreach.org/socat/download/socat-#{version}.tar.gz"
  source_sha256 '06602ffd591e98c75b3dc1d66f0f19136cc666b0b2d95caad987d6ab2cb28097'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0a4f9fd3a724cab56181d8154dad9533a24aafd978530bf4a541e1611adb4b81',
     armv7l: '0a4f9fd3a724cab56181d8154dad9533a24aafd978530bf4a541e1611adb4b81',
       i686: '7c1452afa2d1c9b4ce800f27e46662ca32858b276fa4a6e0bd9871a92734d342',
     x86_64: '279800e2e40f55e111718948b7607e416aec3ad6f3def2f29b0258f97a70a8ed'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'openssl' => :executable
  depends_on 'readline' => :executable
  depends_on 'tcpwrappers' => :executable
end
