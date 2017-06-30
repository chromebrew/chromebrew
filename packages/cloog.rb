require 'package'

class Cloog < Package
  description 'Chunky Loop Generator which is used to perform optimization in gcc'
  homepage 'https://www.cloog.org/'
  version '0.18.4-1'
  binary_url ({
    aarch64: 'https://github.com/jam7/chrome-cross/releases/download/v1.7/cloog-0.18.4-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/cloog-0.18.4-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chrome-cross/releases/download/v1.7/cloog-0.18.4-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chrome-cross/releases/download/v1.7/cloog-0.18.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5c0d563960076a50f332cf484d5ceb7043045ae6f647e74d86a141158b4fa621',
    armv7l:  '5c0d563960076a50f332cf484d5ceb7043045ae6f647e74d86a141158b4fa621',
    i686:    'b82930b14f6b1a506150c3b367f455d8fd78b20a1dacbd53a18b369e32552512',
    x86_64:  '092a6621231b76f4cd331cdac356281185dcff3a8d62d982baee58f20f1aaec8',
  })
end
