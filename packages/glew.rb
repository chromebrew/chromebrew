require 'package'

class Glew < Package
  description 'GLEW provides efficient run-time mechanisms for determining which OpenGL extensions are supported on the target platform'
  homepage 'http://glew.sourceforge.net/'
  version '2.2.0-rc3'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/glew/files/glew/snapshots/glew-20200115.tgz/download'
  source_sha256 '314219ba1db50d49b99705e8eb00e83b230ee7e2135289a00b5b570e4a4db43a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glew-2.2.0-rc3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glew-2.2.0-rc3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glew-2.2.0-rc3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glew-2.2.0-rc3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0912816e2c59d5a677f0b777ac92b7ac92262a9bf8daa5ab5c9e182b95cb9836',
     armv7l: '0912816e2c59d5a677f0b777ac92b7ac92262a9bf8daa5ab5c9e182b95cb9836',
       i686: 'f2b24b7826fe5c8b46a333ae7ece33a1d3a6a73f2f499c769a8a22fae4d7b53e',
     x86_64: '3c79783cf39d26b793fed5b0b9d655febda3ec57336cdacd597f574fc29253bb',
  })

  depends_on 'mesa'

  def self.patch
    system 'tar fxv ../download'
    Dir.chdir 'glew-2.2.0/build' do
      # As per https://github.com/nigels-com/glew/pull/268
      system "sed -i 's/OpenGL::EGL/NOT OpenGL_EGL_FOUND/' cmake/CMakeLists.txt"
      system "sed -i 's/endif()/endif ()/g' cmake/CMakeLists.txt"
    end
  end

  def self.build
    #ENV['CFLAGS.EXTRA'] = "-fuse-ld=lld"
    #ENV['CFLAGS'] = "-fuse-ld=lld"
    #ENV['CXXFLAGS'] = "-fuse-ld=lld"
    ENV['GLEW_DEST'] = "#{CREW_PREFIX}"
    Dir.chdir 'glew-2.2.0/build' do
      system 'cmake',
             '-DCMAKE_BUILD_TYPE=Release',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX}",
             './cmake'
      system 'make', "SYSTEM=linux-egl"
    end
  end

  def self.install
    Dir.chdir 'glew-2.2.0/build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
