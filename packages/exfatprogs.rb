require 'buildsystems/autotools'

class Exfatprogs < Autotools
  description 'exFAT filesystem userspace utilities for the Linux Kernel exfat driver.'
  homepage 'https://github.com/exfatprogs/exfatprogs'
  version '1.3.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/exfatprogs/exfatprogs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd5e3d6cf01e7ad17d77d1b711991f9088d99ee63c2161acc2754e54a4efa7d20',
     armv7l: 'd5e3d6cf01e7ad17d77d1b711991f9088d99ee63c2161acc2754e54a4efa7d20',
       i686: 'e5ac634097807de4f1545610c2094a2eedaf32946f38c82b032f8ad56c35d632',
     x86_64: '2d254bcf1512abf0fb922f225ce0bd7a014741de3036cc88fd870105ccd4d225'
  })

  depends_on 'glibc' => :executable
end
