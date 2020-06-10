require 'package'

class Plplot < Package
  description 'PLplot is a cross-platform software package for creating scientific plots'
  homepage 'http://plplot.sourceforge.net/'
  version '5.15.0'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/plplot/plplot/5.15.0%20Source/plplot-5.15.0.tar.gz'
  source_sha256 'b92de4d8f626a9b20c84fc94f4f6a9976edd76e33fb1eae44f6804bdcc628c7b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/plplot-5.15.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/plplot-5.15.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/plplot-5.15.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/plplot-5.15.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '13f6b739b87349e98ec82b542d0bce70b982f76b7e72ede1ff22d8f020bc05d3',
     armv7l: '13f6b739b87349e98ec82b542d0bce70b982f76b7e72ede1ff22d8f020bc05d3',
       i686: 'c3026a75081479d1722ef82f9e9c917eba87eea2c574ef2ea098479525ce5b1f',
     x86_64: '6aa2d9509f13283391d604ae0e3d9ff501f0ccf3a527ac0fe6e584d20d2f30a0',
  })

  depends_on 'jdk8'
  depends_on 'libharu'
  depends_on 'lua'
  depends_on 'ocaml'
  depends_on 'pango'
  depends_on 'qhull'
  depends_on 'qtsvg'
  depends_on 'swig'
  depends_on 'tk'
  depends_on 'wxwidgets'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             '-DBUILD_TEST=ON',
             '-DENABLE_DYNDRIVERS=OFF',
             '-DUSE_INCRTCL_VERSION_4=ON',
             "-DLIB_DIR=#{CREW_LIB_PREFIX}",
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '..'
      system 'make'
    end
  end

  def self.check
    Dir.chdir 'build' do
      #system 'ctest'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
