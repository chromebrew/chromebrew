require 'buildsystems/autotools'

class Calcurse < Autotools
  description 'calcurse is a calendar and scheduling application for the command line.'
  homepage 'https://calcurse.org/'
  version '4.9.1'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://calcurse.org/files/calcurse-#{version}.tar.gz"
  source_sha256 '17621360d80f154aebf082ff52f5b3bfe43386a72e4f2c44e18f45a980b502b6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '276c2a66dab4b2f5a3fc7009ca090ffd5f1daff665261b49fe92124b98f71274',
     armv7l: '276c2a66dab4b2f5a3fc7009ca090ffd5f1daff665261b49fe92124b98f71274',
       i686: 'f7bea9183d70e31ff25de68c544cea8f34d426f9d3aacabfcd495b2f65c6b195',
     x86_64: 'f1447e168a5b2fd2762638f4a31567c3d34a5110d3aa7a0a7833c6377380b361'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable

  autotools_configure_options "CFLAGS='-I#{CREW_PREFIX}/include/ncursesw'"
end
