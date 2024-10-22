require 'buildsystems/autotools'

class Libtirpc < Autotools
  description 'Libtirpc is a port of Suns Transport-Independent RPC library to Linux.'
  homepage 'https://sourceforge.net/projects/libtirpc/'
  version '1.3.6'
  license 'GPL-2'
  compatibility 'all'
  source_url "http://downloads.sourceforge.net/project/libtirpc/libtirpc/#{version}/libtirpc-#{version}.tar.bz2"
  source_sha256 '1e0b0c7231c5fa122e06c0609a76723664d068b0dba3b8219b63e6340b347860'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3c31698448bc7d4da06f459208026c5a014362818382893e3f59a8b498dfc2d9',
     armv7l: '3c31698448bc7d4da06f459208026c5a014362818382893e3f59a8b498dfc2d9',
       i686: 'f0706400548d723d0e19582ed8b66feabfd63e4eb47d20f33d79fb10cef19210',
     x86_64: 'ed830cd8a2603ea3507efe334b22fd696b9b72f4b70b473f8c6b1e25236be281'
  })

  depends_on 'e2fsprogs' # R
  depends_on 'glibc' # R
  depends_on 'krb5' # R
end
