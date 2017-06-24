require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'http://www.gnu.org/software/binutils/'
  version '2.25-2'
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.7/binutils-2.25-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/binutils-2.25-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.7/binutils-2.25-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/binutils-2.25-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    aarch64: '575c926920389cb4aff2b593a833097f85cee2fe',
    armv7l:  '575c926920389cb4aff2b593a833097f85cee2fe',
    i686:    'bb24463e862fd812a8ccbac5b5e2920f54fecacd',
    x86_64:  'e02063609a97e1f061df96b68299910ff7be59d4',
  })
end
