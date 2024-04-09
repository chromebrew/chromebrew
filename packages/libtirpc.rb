require 'buildsystems/autotools'

class Libtirpc < Autotools
  description 'Libtirpc is a port of Suns Transport-Independent RPC library to Linux.'
  homepage 'https://sourceforge.net/projects/libtirpc'
  version '1.3.4'
  license 'GPL-2'
  compatibility 'all'
  source_url "http://downloads.sourceforge.net/project/libtirpc/libtirpc/#{version}/libtirpc-#{version}.tar.bz2"
  source_sha256 '1e0b0c7231c5fa122e06c0609a76723664d068b0dba3b8219b63e6340b347860'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e50a429b7df4cacb0895f5a0c387934e0fb12ec38733019db46236bcd5c19dc8',
     armv7l: 'e50a429b7df4cacb0895f5a0c387934e0fb12ec38733019db46236bcd5c19dc8',
       i686: 'ab43a0bd0f003df12fce5a0fc64ba445ad040cf63832fc587e602cf40d96cfbf',
     x86_64: '010df2b2eab43e5f646b768042d98e846553fcbfe4a5356c886d9c031921222a'
  })

  depends_on 'e2fsprogs' # R
  depends_on 'glibc' # R
  depends_on 'krb5' # R
end
