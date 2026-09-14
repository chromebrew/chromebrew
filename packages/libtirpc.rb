require 'buildsystems/autotools'

class Libtirpc < Autotools
  description 'Libtirpc is a port of Suns Transport-Independent RPC library to Linux.'
  homepage 'https://sourceforge.net/projects/libtirpc/'
  version '1.3.8'
  license 'GPL-2'
  compatibility 'all'
  source_url "http://downloads.sourceforge.net/project/libtirpc/libtirpc/#{version}/libtirpc-#{version}.tar.bz2"
  source_sha256 '8839959bfcc7a0f4c609d8e4f53f1c67ae33de23775ec35beb39ff15adf11920'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2b3a5ab0971b9eee3a31df56ad34fc400697a060bd4fc2fff872a8cd2ccfbdfd',
     armv7l: '2b3a5ab0971b9eee3a31df56ad34fc400697a060bd4fc2fff872a8cd2ccfbdfd',
       i686: '8cf3754491db3ae4351ebcb817fcda356e926734a656e1c224c64c041e581514',
     x86_64: '6bd993acd91e3a2271e5e2fd0a0433bd0e2f67ffc90fe5afe484dc3cfa031be3'
  })

  depends_on 'e2fsprogs' => :library
  depends_on 'glibc' => :library
  depends_on 'krb5' => :library
end
