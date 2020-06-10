require 'package'

class Doxygen < Package
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources, but it also supports other popular programming languages such as C, Objective-C, C#, PHP, Java, Python, IDL (Corba, Microsoft, and UNO/OpenOffice flavors), Fortran, VHDL, Tcl, and to some extent D.'
  homepage 'http://www.doxygen.nl/'
  version '1.8.17'
  compatibility 'all'
  source_url 'https://github.com/doxygen/doxygen/archive/Release_1_8_17.tar.gz'
  source_sha256 '1b5d337e4b73ef1357a88cbd06fc4c301f08f279dac0adb99e876f4d72361f4f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.17-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.17-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.17-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.17-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f775a0bd1f0ac17e216d5be7667e605bb8b819426dcd87ccb79547978883e79f',
     armv7l: 'f775a0bd1f0ac17e216d5be7667e605bb8b819426dcd87ccb79547978883e79f',
       i686: 'f6a9e88ac424e38e19df517723af86c2b3296d6119d24073ff411bd3988d1603',
     x86_64: 'ff5909d7d941b2a9e29ffc2c1d54613f65c57ff5ac4bae186264f63614ee6be3',
  })

  depends_on 'python27' => :build

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX:PATH=#{CREW_PREFIX}",
             "-DCMAKE_LIBRARY_PATH=#{CREW_LIB_PREFIX}",
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
