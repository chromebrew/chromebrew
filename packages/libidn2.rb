require 'buildsystems/autotools'

class Libidn2 < Autotools
  description 'GNU Libidn is a fully documented implementation of the Stringprep, Punycode and IDNA 2003 specifications.'
  homepage 'https://www.gnu.org/software/libidn/'
  @_ver = '2.3.4'
  version "#{@_ver}-1"
  license 'GPL-2+ and LGPL-3+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/libidn/libidn2-#{@_ver}.tar.gz"
  source_sha256 '93caba72b4e051d1f8d4f5a076ab63c99b77faee019b72b9783b267986dbb45f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.4-1_armv7l/libidn2-2.3.4-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.4-1_armv7l/libidn2-2.3.4-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.4-1_i686/libidn2-2.3.4-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.4-1_x86_64/libidn2-2.3.4-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'adbffb0615f7f292642ef4b6b279ebe8f4f588e931b10aa804aa29faf6054857',
     armv7l: 'adbffb0615f7f292642ef4b6b279ebe8f4f588e931b10aa804aa29faf6054857',
       i686: '26e053300160392951cbc6a1442cc9a93e34949f59db06d79ced10211812ec69',
     x86_64: 'c52ce4eb1cdd80d6cd9bbe5df1c212b21e51d076ec23b6c443e25d76e62cb515'
  })

  depends_on 'glibc' # R
  depends_on 'libunistring' # R
end
