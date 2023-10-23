require 'buildsystems/autotools'

class Libidn2 < Autotools
  description 'GNU Libidn is a fully documented implementation of the Stringprep, Punycode and IDNA 2003 specifications.'
  homepage 'https://www.gnu.org/software/libidn/'
  @_ver = '2.3.4'
  version @_ver.to_s
  license 'GPL-2+ and LGPL-3+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/libidn/libidn2-#{@_ver}.tar.gz"
  source_sha256 '93caba72b4e051d1f8d4f5a076ab63c99b77faee019b72b9783b267986dbb45f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.4_armv7l/libidn2-2.3.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.4_armv7l/libidn2-2.3.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.4_i686/libidn2-2.3.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.4_x86_64/libidn2-2.3.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '18bea2e795b0d89edd145907844491f4c51084e0fe1755bc1b20644dac3c057d',
     armv7l: '18bea2e795b0d89edd145907844491f4c51084e0fe1755bc1b20644dac3c057d',
       i686: '461c449554f576be0838ed99730b54e07ce0665e7daf35f9967ffa9c4b39c4a9',
     x86_64: '038b5495c68dd2b9a85cec0ea83eee6aa9740a8a8b31557fb61465b0fc5c7947'
  })

  depends_on 'glibc' # R
  depends_on 'libunistring' # R
end
