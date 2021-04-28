require 'package'

class Gcc10 < Package
  description 'The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Ada, and Go.'
  homepage 'https://www.gnu.org/software/gcc/'
  version '10.3.0'
  license 'GPL-3'
  compatibility 'all'
  
    is_fake

    depends_on 'libssp'

  end
