require 'package'

class Doxygen < Package
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources, but it also supports other popular programming languages such as C, Objective-C, C#, PHP, Java, Python, IDL (Corba, Microsoft, and UNO/OpenOffice flavors), Fortran, VHDL, Tcl, and to some extent D.'
  homepage 'http://www.doxygen.nl/'
  version '1.8.16'
  source_url 'https://github.com/doxygen/doxygen/archive/Release_1_8_16.tar.gz'
  source_sha256 '75b18117f88ca1930ab74c05f6712690a26dd4fdcfc9d7d5324be43160645fb4'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'cmake' => :build
  depends_on 'python27' => :build

  def self.build
    system 'mkdir -p build'
    Dir.chdir('build') do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX:PATH=#{CREW_PREFIX}",
             "-DCMAKE_LIBRARY_PATH=#{CREW_LIB_PREFIX}",
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir('build') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
