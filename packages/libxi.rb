require 'buildsystems/autotools'

class Libxi < Autotools
  description 'X.org libXi Client library for XInput'
  homepage 'https://x.org/wiki/'
  version '1.8.4'
  license 'MIT and custom'
  compatibility 'all'
  source_url "https://www.x.org/archive/individual/lib/libXi-#{version}.tar.gz"
  source_sha256 '4d52f03b693cf3b32ae21701310cce34344ec8535f50d1667b1510a7083eca4a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a2a4acb225f8f64b6256425bd6b6cd4f70edb71fa36422690f3827141c9cf27b',
     armv7l: 'a2a4acb225f8f64b6256425bd6b6cd4f70edb71fa36422690f3827141c9cf27b',
       i686: 'c808d94a1be5754e3cf55d29a2292c6b1dc639d89466a3e0bca6cdc26bf97faa',
     x86_64: '102295c1d7d12bb928a86637bb4e194824e977cba6ba190ec79540de13892229'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libbsd' => :library
  depends_on 'libx11' => :library
  depends_on 'libxau' => :library
  depends_on 'libxcb' => :library
  depends_on 'libxdmcp' => :library
  depends_on 'libxext' => :library
  depends_on 'libxfixes' => :build
  depends_on 'xorg_proto' => :build
end
