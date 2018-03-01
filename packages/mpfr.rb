require 'package'

class Mpfr < Package
  description 'The MPFR library is a C library for multiple-precision floating-point computations with correct rounding.'
  homepage 'http://www.mpfr.org/'
  version '3.1.5-2'
  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew-cross/mpfr-3.1.5-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew-cross/mpfr-3.1.5-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew-cross/mpfr-3.1.5-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew-cross/mpfr-3.1.5-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '41170f3c49ea226df739d90bb633895dc0479d855acece2cd96d1bb24818202a',
     armv7l: '41170f3c49ea226df739d90bb633895dc0479d855acece2cd96d1bb24818202a',
       i686: '341e8109fbfc376883e5eeb649561897958a8cbf92ba3dc73ca7da5e52fa7e63',
     x86_64: '5e9fe71170cc82e1d789ee9aecf568b70f4f9694f2c945a6c04ae573bf0509a2',
  })
end
