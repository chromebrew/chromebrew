require 'package'

class Openjpeg < Package
  description 'OpenJPEG is an open-source JPEG 2000 codec written in C language.'
  homepage 'https://github.com/uclouvain/openjpeg/'
  version '2.3.1'
  compatibility 'all'
  source_url 'https://github.com/uclouvain/openjpeg/archive/v2.3.1.tar.gz'
  source_sha256 '63f5a4713ecafc86de51bfad89cc07bb788e9bba24ebbf0c4ca637621aadb6a9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openjpeg-2.3.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openjpeg-2.3.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openjpeg-2.3.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openjpeg-2.3.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5cbfa188b4ef0e9adb59280c0adfdbeae57751743000afbaca8574a9e3349b59',
     armv7l: '5cbfa188b4ef0e9adb59280c0adfdbeae57751743000afbaca8574a9e3349b59',
       i686: 'c63933b2976c97ebcaea35ced82598958377b6e8fa9e984c74eca40afdcd9c40',
     x86_64: '921c73296cf057b4c5606470c3de038492de21177b82ed659213dd04348aef33',
  })

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DOPENJPEG_INSTALL_LIB_DIR=#{CREW_LIB_PREFIX}",
             '-DCMAKE_BUILD_TYPE=Release',
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'builddir' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
