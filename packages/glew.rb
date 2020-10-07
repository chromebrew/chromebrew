require 'package'

class Glew < Package
  description 'GLEW provides efficient run-time mechanisms for determining which OpenGL extensions are supported on the target platform'
  homepage 'http://glew.sourceforge.net/'
  version '2.2.0-rc3'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/glew/files/glew/snapshots/glew-20200115.tgz/download'
  source_sha256 '314219ba1db50d49b99705e8eb00e83b230ee7e2135289a00b5b570e4a4db43a'


  depends_on 'mesa'
  depends_on 'llvm'

  def self.build
    system 'tar fxv ../download'
    ENV['CFLAGS.EXTRA'] = "-fuse-ld=lld"
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    ENV['GLEW_DEST'] = "#{CREW_PREFIX}"
    Dir.chdir 'glew-2.2.0/build' do
      # As per https://github.com/nigels-com/glew/pull/268
      system "sed -i 's/OpenGL::EGL/NOT OpenGL_EGL_FOUND/' cmake/CMakeLists.txt"
      system "sed -i 's/endif()/endif ()/g' cmake/CMakeLists.txt"
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
