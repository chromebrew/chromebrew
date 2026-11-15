require 'buildsystems/autotools'

class Ntfs_3g < Autotools
  description 'NTFS-3G Safe Read/Write NTFS Driver'
  homepage 'https://github.com/tuxera/ntfs-3g'
  version '2026.9.28'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/tuxera/ntfs-3g.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e30e624f1010c70d760a67d62b2045354742acae84c853053f8ec26b41931389',
     armv7l: 'e30e624f1010c70d760a67d62b2045354742acae84c853053f8ec26b41931389',
       i686: '30b19fd3042304960865bce8e53ee8ee7357b55db994aee8267129150bd5f12a',
     x86_64: '5fa967ed394ef25fc76f56809efb9074ba9d83b55d81c49d61a6e6489ede1e66'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'util_linux' => :executable

  autotools_configure_options "--exec-prefix=#{CREW_PREFIX} --disable-ntfs-3g"
end
