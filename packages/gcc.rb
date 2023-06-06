require 'package'
require_relative 'gcc_build'

class Gcc < Package
  description 'The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Ada, and Go.'
  homepage Gcc_build.homepage.to_s
  version Gcc_build.version.to_s
  license Gcc_build.license
  compatibility Gcc_build.compatibility.to_s

  is_fake

  depends_on 'gcc_lib'
  depends_on 'gcc_dev'
end
