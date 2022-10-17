require 'package'

class Doxygen < Package
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources, but it also supports other popular programming languages such as C, Objective-C, C#, PHP, Java, Python, IDL (Corba, Microsoft, and UNO/OpenOffice flavors), Fortran, VHDL, Tcl, and to some extent D.'
  homepage 'http://www.doxygen.nl/'
  version '1.9.5'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/doxygen/doxygen/archive/Release_1_9_5.tar.gz'
  source_sha256 '1c5c9cd4445f694e43f089c17529caae6fe889b732fb0b145211025a1fcda1bb'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doxygen/1.9.5_armv7l/doxygen-1.9.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doxygen/1.9.5_armv7l/doxygen-1.9.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doxygen/1.9.5_i686/doxygen-1.9.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doxygen/1.9.5_x86_64/doxygen-1.9.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '29e7040a1a35caf72ed743594a2f4f41e9e20ca240865be676d1c3b6a25368da',
     armv7l: '29e7040a1a35caf72ed743594a2f4f41e9e20ca240865be676d1c3b6a25368da',
       i686: '3ed03d545754891a70844fc88b6cbcb74123262dd065d4e8d04ed9ba78d2d4cf',
     x86_64: 'f4552b1b37b871beed3c94659a72da80ceb20e802e1afc1c78eeab6bab29b7e0'
  })

  depends_on 'python3' => :build

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake -G Ninja \
            #{CREW_CMAKE_OPTIONS} \
            .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
