require 'package'

class Graphite < Package
  description 'Reimplementation of the SIL Graphite text processing engine'
  homepage 'https://github.com/silnrsi/graphite'
  version '1.3.14'
  compatibility 'all'
  source_url 'https://github.com/silnrsi/graphite/releases/download/1.3.14/graphite2-1.3.14.tgz'
  source_sha256 'f99d1c13aa5fa296898a181dff9b82fb25f6cc0933dbaa7a475d8109bd54209d'

  depends_on 'freetype'
  
  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
    case ARCH
      when 'x86_64'
          system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DCMAKE_INSTALL_LIBDIR=#{ARCH_LIB}",
             '-DCMAKE_BUILD_TYPE=Release',
             '-DLIB_SUFFIX=64',
             '..'
     else
          system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DCMAKE_INSTALL_LIBDIR=#{ARCH_LIB}",
             '-DCMAKE_BUILD_TYPE=Release',
             '..'
      end
      system 'make'
    end
  end
  
 def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
