require 'buildsystems/autotools'

class Ntfs_3g < Autotools
  description 'NTFS-3G Safe Read/Write NTFS Driver'
  homepage 'https://github.com/tuxera/ntfs-3g'
  version '2026.7.7'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/tuxera/ntfs-3g.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd3889f33b1cb1ae67360d0ee0512485d70297cb4d7bd5e0b5fd51ecedd972f78',
     armv7l: 'd3889f33b1cb1ae67360d0ee0512485d70297cb4d7bd5e0b5fd51ecedd972f78',
       i686: 'c14fddbe6dc3a442429db9faac6f6d5556b23bf0158c3a6cc64dfcafee3481f1',
     x86_64: '15abdccc0e701d0a0f74dfa133d6e579d739eeb6748a1eeda9d96afe01d0ba46'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'util_linux' => :executable

  autotools_configure_options "--exec-prefix=#{CREW_PREFIX} --disable-ntfs-3g"
end
