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
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  configure_options "--exec-prefix=#{CREW_PREFIX} --disable-ntfs-3g"
end
