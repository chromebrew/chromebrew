require 'package'

class Gcc_build < Package
  gcc_build_obj = Package.load_package("#{__dir__}/#{CREW_GCC_VER}_build.rb")
  description 'The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Ada, Go, and for 64bit: COBOL.'
  homepage gcc_build_obj.homepage
  version gcc_build_obj.version
  license gcc_build_obj.license
  compatibility gcc_build_obj.compatibility

  is_fake
end
