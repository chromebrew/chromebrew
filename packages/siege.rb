require 'buildsystems/autotools'

class Siege < Autotools
  description 'Siege is an http load testing and benchmarking utility.'
  homepage 'https://www.joedog.org/siege-home/'
  version '4.2.2'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://download.joedog.org/siege/siege-#{version}.tar.gz"
  source_sha256 'c0d5bfac11086aeb3828888a71bf276ed54c9fa0f0af2ead981d2b2fa242141b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bc527077bf7c5aebe7df4018fa8d8bc217491755a3d67e18413ad99dfbcb89eb',
     armv7l: 'bc527077bf7c5aebe7df4018fa8d8bc217491755a3d67e18413ad99dfbcb89eb',
       i686: '618a34ec74d3aa6729d58f8888cb8e3b6a9c4331d44b9420748ac1bba973077a',
     x86_64: '7faf8bcec167a1bf32a94516ba69486aaaa2d19620916d6fa14225005df17b71'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'openssl' => :executable
  depends_on 'util_linux' => :executable
  depends_on 'zlib' => :executable
end
