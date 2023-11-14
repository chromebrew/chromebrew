require 'buildsystems/autotools'

class Sed < Autotools
  description 'sed (stream editor) is a non-interactive command-line text editor.'
  homepage 'https://www.gnu.org/software/sed/'
  version '4.9-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/sed/sed-4.9.tar.xz'
  source_sha256 '6e226b732e1cd739464ad6862bd1a1aba42d7982922da7a53519631d24975181'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sed/4.9_armv7l/sed-4.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sed/4.9_armv7l/sed-4.9-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sed/4.9_i686/sed-4.9-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sed/4.9_x86_64/sed-4.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6ad05b86518b574fab280df0788fbb7deffb99effee3b0b38222488dcaad3288',
     armv7l: '6ad05b86518b574fab280df0788fbb7deffb99effee3b0b38222488dcaad3288',
       i686: 'ed4650bbd4246cb3f4af2963cb3fc8cacbabcd94794c52ebc07fb45ac52369f5',
     x86_64: '05c6b559843f27da3226b088ccca87f8eba68e49d994507e28d11e4bc4aff661'
  })

  depends_on 'acl' # R
  depends_on 'glibc' # R

  configure_options '--without-selinux'
end
