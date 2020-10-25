require 'package'

class Graphite < Package
  description 'Reimplementation of the SIL Graphite text processing engine'
  homepage 'https://github.com/silnrsi/graphite'
  version '1.3.14-1'
  compatibility 'all'
  source_url 'https://github.com/silnrsi/graphite/releases/download/1.3.14/graphite2-1.3.14.tgz'
  source_sha256 'f99d1c13aa5fa296898a181dff9b82fb25f6cc0933dbaa7a475d8109bd54209d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/graphite-1.3.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/graphite-1.3.14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/graphite-1.3.14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/graphite-1.3.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9820ae85855aa87264a16ee685ccafb83ef0a47ae3d90870d29f975aa2826bb1',
     armv7l: '9820ae85855aa87264a16ee685ccafb83ef0a47ae3d90870d29f975aa2826bb1',
       i686: '2a4fa173fd103be07f1d3b571136ce88bfc30915b8cbf3c5286028b022505067',
     x86_64: '4fa9b76604330c23c0cf84650698c21e2715a42238841f963bbd6dcf4785ba77',
  })

  depends_on 'freetype_sub' => :build
  
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
