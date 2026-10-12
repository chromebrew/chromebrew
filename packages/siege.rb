require 'buildsystems/autotools'

class Siege < Autotools
  description 'Siege is an http load testing and benchmarking utility.'
  homepage 'https://www.joedog.org/siege-home/'
  version '4.2.0'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://download.joedog.org/siege/siege-#{version}.tar.gz"
  source_sha256 '78af482fc655f1cf7270fdbc3171581ed4cb3163009f7f4f056fc2b7e2d24453'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fcaedde74daa4af1989b1876ca76532ea90a5e943f73701d31c4b5244285cb13',
     armv7l: 'fcaedde74daa4af1989b1876ca76532ea90a5e943f73701d31c4b5244285cb13',
       i686: '4806d54ea01aba33f17c2816db1eba2cbb6bc09e58cedddc1b7b76e4e4ce5180',
     x86_64: '19223a776a957751da1d826d21bfefbf839be515d7eabdc72dcdb45b7ab26084'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'openssl' => :executable
  depends_on 'util_linux' => :executable
  depends_on 'zlib' => :executable
end
