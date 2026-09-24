require 'buildsystems/autotools'

class Ntfs_3g < Autotools
  description 'NTFS-3G Safe Read/Write NTFS Driver'
  homepage 'https://github.com/tuxera/ntfs-3g'
  version '2026.9.18'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/tuxera/ntfs-3g.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f77a10d42ca6ef6d2a8f93eb27a9d3b6c70c4aeb57d0fcf01a27158e6ff9ca2',
     armv7l: '5f77a10d42ca6ef6d2a8f93eb27a9d3b6c70c4aeb57d0fcf01a27158e6ff9ca2',
       i686: 'a712d8ce0527e8b4acc285a84f46393982a7777b4d3e1d1a76a1ca92dbaa1f1f',
     x86_64: '85d1a62fa5c5a5cfee7c181d314215cc655b29d76f1ea17e5d46662baa8c243d'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'util_linux' => :executable

  autotools_configure_options "--exec-prefix=#{CREW_PREFIX} --disable-ntfs-3g"
end
