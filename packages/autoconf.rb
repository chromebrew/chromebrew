require 'buildsystems/autotools'

class Autoconf < Autotools
  description 'Autoconf is an extensible package of M4 macros that produce shell scripts to automatically configure software source code packages.'
  homepage 'http://www.gnu.org/software/autoconf/'
  version '2.72'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/autoconf/autoconf-2.72.tar.xz'
  source_sha256 'ba885c1319578d6c94d46e9b0dceb4014caafe2490e437a0dbca3f270a223f5a'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/autoconf/2.72_armv7l/autoconf-2.72-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/autoconf/2.72_armv7l/autoconf-2.72-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/autoconf/2.72_i686/autoconf-2.72-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/autoconf/2.72_x86_64/autoconf-2.72-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1afb15ee3b59839b1db68a3a498b226b98b55bbb4080398860c832a5ec9e1afd',
     armv7l: '1afb15ee3b59839b1db68a3a498b226b98b55bbb4080398860c832a5ec9e1afd',
       i686: 'feb717b740e3277a2d75430a128690cdd4a722ebc80c9d94ca9b2f6019633d1d',
     x86_64: 'cc237426fdda757d28d9413e669e7d4003f8062b4e206fb39f5456d86b1e06e1'
  })

  depends_on 'perl'
  depends_on 'm4'
end
