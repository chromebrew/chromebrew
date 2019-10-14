require 'package'

class Doxygen < Package
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources, but it also supports other popular programming languages such as C, Objective-C, C#, PHP, Java, Python, IDL (Corba, Microsoft, and UNO/OpenOffice flavors), Fortran, VHDL, Tcl, and to some extent D.'
  homepage 'http://www.doxygen.nl/'
  version '1.8.16'
  source_url 'https://github.com/doxygen/doxygen/archive/Release_1_8_16.tar.gz'
  source_sha256 '75b18117f88ca1930ab74c05f6712690a26dd4fdcfc9d7d5324be43160645fb4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.16-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.16-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.16-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.16-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '793adb5e56f25d53f65425fc6dd46265162d0666b3824f888a7f87f97b8df28a',
     armv7l: '793adb5e56f25d53f65425fc6dd46265162d0666b3824f888a7f87f97b8df28a',
       i686: '1a6c70c753bb8e39414ec40796327c44e53785bcb5ad497b1f1657e9479db39c',
     x86_64: '83d8ee661a07fc7e70f818f5a58901702cc38d66898c7d51bbd2e8269b8bdca7',
  })

  depends_on 'cmake' => :build
  depends_on 'python27' => :build

  def self.build
    Dir.mkdir('build')
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
