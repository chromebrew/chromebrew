require 'package'

class Binutils < Package
  version '2.25-1'
  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/newtoolchains/binutils-2.25-1-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chromebrew/releases/download/newtoolchains/binutils-2.25-1-chromeos-armv7l.tar.xz',
    i686:    'https://github.com/jam7/chromebrew/releases/download/newtoolchains/binutils-2.25-1-chromeos-i686.tar.xz',
    x86_64:  'https://github.com/jam7/chromebrew/releases/download/newtoolchains/binutils-2.25-1-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    aarch64: '5a4b3c8ddcac5d1b3fdc2f6aee8c9ec64f2d23ea',
    armv7l:  '5a4b3c8ddcac5d1b3fdc2f6aee8c9ec64f2d23ea',
    i686:    '9d8d586e5e44badbe1f2058f53c183c019353a0e',
    x86_64:  '94d246a14efc080a398aefe9e192331a4ffaed46',
  })
end
