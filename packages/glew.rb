require 'package'

class Glew < Package
  description 'GLEW provides efficient run-time mechanisms for determining which OpenGL extensions are supported on the target platform'
  homepage 'http://glew.sourceforge.net/'
  version '2.2.0'
  license 'BSD and MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://sourceforge.net/projects/glew/files/glew/2.2.0/glew-2.2.0.tgz/download'
  source_sha256 'd4fc82893cfb00109578d0a1a2337fb8ca335b3ceccf97b97e5cc7f08e4353e1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '20c0ed7ae6a12d3a3b852d7d3b9f27bb9bcc9eeb13843767a599b055cde8f77e',
     armv7l: '20c0ed7ae6a12d3a3b852d7d3b9f27bb9bcc9eeb13843767a599b055cde8f77e',
     x86_64: '4ac9705c4f6836b04286e85d8e0da547c59de28c98119e3654358f27c1b387a3'
  })

  depends_on 'mesa'

  def self.patch
    system 'tar fxv download'
    Dir.chdir 'glew-2.2.0/build' do
      # As per https://github.com/nigels-com/glew/pull/268
      system "sed -i 's/OpenGL::EGL/NOT OpenGL_EGL_FOUND/' cmake/CMakeLists.txt"
      system "sed -i 's/endif()/endif ()/g' cmake/CMakeLists.txt"
    end
  end

  def self.build
    ENV['GLEW_DEST'] = CREW_PREFIX
    Dir.chdir 'glew-2.2.0/build' do
      system "cmake #{CREW_CMAKE_OPTIONS} cmake"
      system 'make', 'SYSTEM=linux-egl'
    end
  end

  def self.install
    Dir.chdir 'glew-2.2.0/build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
