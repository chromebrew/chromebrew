require 'buildsystems/autotools'

class Libxi < Autotools
  description 'X.org libXi Client library for XInput'
  homepage 'https://x.org/wiki/'
  version '1.8.3'
  license 'MIT and custom'
  compatibility 'all'
  source_url "https://www.x.org/archive/individual/lib/libXi-#{version}.tar.gz"
  source_sha256 '6648c44127e4585f4e7842c0802d265008fa6f9741df0ea6ee7934a5267adf63'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8c72b199acaf1a3d3e378f804225897c4b71a918c6a2ca4d3e4c7ee3694e33c0',
     armv7l: '8c72b199acaf1a3d3e378f804225897c4b71a918c6a2ca4d3e4c7ee3694e33c0',
       i686: '241a80160121a6f5409ffb9f87063cba4dee6f2e5884e9014e7418d48efce24c',
     x86_64: 'bbd43e1feb0c339e46ff4c45828ce3e1b50e921bc9ff1bc3623601c2c64a9488'
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
