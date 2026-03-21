require 'buildsystems/autotools'

class Autoconf < Autotools
  description 'Autoconf is an extensible package of M4 macros that produce shell scripts to automatically configure software source code packages.'
  homepage 'http://www.gnu.org/software/autoconf/'
  version '2.73'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/autoconf/autoconf-#{version}.tar.xz"
  source_sha256 '9fd672b1c8425fac2fa67fa0477b990987268b90ff36d5f016dae57be0d6b52e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1afb15ee3b59839b1db68a3a498b226b98b55bbb4080398860c832a5ec9e1afd',
     armv7l: '1afb15ee3b59839b1db68a3a498b226b98b55bbb4080398860c832a5ec9e1afd',
       i686: 'feb717b740e3277a2d75430a128690cdd4a722ebc80c9d94ca9b2f6019633d1d',
     x86_64: 'cc237426fdda757d28d9413e669e7d4003f8062b4e206fb39f5456d86b1e06e1'
  })

  depends_on 'perl'
  depends_on 'm4'
end
