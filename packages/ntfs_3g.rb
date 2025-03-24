require 'buildsystems/autotools'

class Ntfs_3g < Autotools
  description 'NTFS-3G Safe Read/Write NTFS Driver'
  homepage 'https://github.com/tuxera/ntfs-3g'
  version '2022.10.3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/tuxera/ntfs-3g.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '20a7ab1f3292de6dd70298bfd1939d09ee1326a2bd6b83da0134bd9142297e53',
     armv7l: '20a7ab1f3292de6dd70298bfd1939d09ee1326a2bd6b83da0134bd9142297e53',
       i686: '03b6d129a013d7f219d3ddd29ece882c6b6821fd4e163d9cef6373970c3a5aa7',
     x86_64: '24498aee82923066f076c889d1df019477797fc6f682d0d49426cd0c31875db2'
  })

  depends_on 'glibc' # R
  depends_on 'util_linux' # R

  configure_options "--exec-prefix=#{CREW_PREFIX} --disable-ntfs-3g"
end
