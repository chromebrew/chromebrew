require 'package'

class Gdb < Package
  description 'The GNU Debugger'
  homepage 'https://www.gnu.org/software/gdb/'
  version '10.2'
  compatibility 'all'
  license 'GPL3'

  depends_on 'binutils' # L (gdb is in binutils)
  depends_on 'boost' # R (gdb only)
  depends_on 'elfutils' # R
  depends_on 'expat' # R (gdb only)
  depends_on 'flex' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libx11' => :build
  depends_on 'mpfr' # R
  depends_on 'ncurses' # R (gdb only)
  depends_on 'python3' # R
  depends_on 'readline' # R (gdb only)
  depends_on 'source_highlight' # R (gdb only)
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R

  is_fake

end
