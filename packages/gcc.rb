require 'package'
require 'open3'

class Gcc < Package
  description 'The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Ada, and Go.'
  homepage 'https://www.gnu.org/software/gcc/'
  version '11.2.0'
  license 'GPL-3, LGPL-3, libgcc, FDL-1.2'
  compatibility 'all'


  begin
    @gcc_ver, status = Open3.capture2("#{CREW_PREFIX}/bin/gcc -dumpversion")
  rescue
  end
  depends_on status.exitstatus == 0 ? "gcc#{@gcc_ver.chomp}" : 'gcc11'
end
