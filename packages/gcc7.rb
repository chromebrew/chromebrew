require 'package'

class Gcc7 < Package
  description 'The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Ada, and Go.'
  homepage 'https://www.gnu.org/software/gcc/'
  version '7.3.0'

  source_url 'https://github.com/gcc-mirror/gcc/archive/gcc-7_3_0-release.zip'

  source_sha256 'd8cb199f0d98bd83e3dac645126722e44137c24cbe5e87e1113dd4270f7530c6'

  depends_on 'gawk'
  depends_on 'unzip' => :build

  def self.build
    system "mkdir", "build"
    Dir.chdir "build" do
      ENV["LIBRARY_PATH"] = "#{CREW_LIB_PREFIX}"
      system "../configure",
             "-v",
             "--libdir=#{CREW_LIB_PREFIX}",
             "--prefix=#{CREW_PREFIX}",
             "--enable-checking=release",
             "--enable-languages=c,c++,fortran",
             "--disable-multilib",
             "--disable-libmpx",
             "--program-suffix=-7.3"
      system "make"
    end
  end

  def self.install
    Dir.chdir "build" do
      ENV["LIBRARY_PATH"] = "#{CREW_LIB_PREFIX}"
      system "make",
             "install-strip"
    end
  end
end
