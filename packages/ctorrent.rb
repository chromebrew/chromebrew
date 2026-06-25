require 'buildsystems/autotools'

class Ctorrent < Autotools
  description 'CTorrent is a BitTorrent client implemented in C++ to be lightweight and quick.'
  homepage 'http://www.rahul.net/dholmes/ctorrent/'
  version '3.3.2'
  license 'GPL-2'
  compatibility 'all'
  source_url "http://www.rahul.net/dholmes/ctorrent/ctorrent-dnh#{version}.tar.gz"
  source_sha256 'c87366c91475931f75b924119580abd06a7b3cb3f00fef47346552cab1e24863'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c25d9d6a8ce729da7d027c4a491898c6fa0ca3aa9337287bfbfdf24062bbde12',
     armv7l: 'c25d9d6a8ce729da7d027c4a491898c6fa0ca3aa9337287bfbfdf24062bbde12',
       i686: '7f40edfe88210f3c48a037a2f362e88fdf5a4efb2f302ee8d579b06965b46ca2',
     x86_64: '3c536ba324ff003adf26eb3861aad8ce493f9a6f94a6e3b8e0eda385a84bd495'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'openssl' => :executable
end
