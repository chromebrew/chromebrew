require 'buildsystems/autotools'

class Ntfs_3g < Autotools
  description 'NTFS-3G Safe Read/Write NTFS Driver'
  homepage 'https://github.com/tuxera/ntfs-3g'
  version '2026.2.25'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/tuxera/ntfs-3g.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6a0945e41b06452ba9b4e7e2b46c45d87a47b0287dd201e94c234d16243bdd92',
     armv7l: '6a0945e41b06452ba9b4e7e2b46c45d87a47b0287dd201e94c234d16243bdd92',
       i686: '075120ba32bbf1b1b4b0cacccb88981f3d0a7981385afbccce56e23f2721ab31',
     x86_64: '7b7ef5e12c8f9d0856575b3dcf0c25ca184a04eb5b65f8416c76b87b1844532b'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'util_linux' => :executable

  autotools_configure_options "--exec-prefix=#{CREW_PREFIX} --disable-ntfs-3g"
end
