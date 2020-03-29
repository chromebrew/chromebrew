require 'package'

class Glew < Package
  description 'GLEW provides efficient run-time mechanisms for determining which OpenGL extensions are supported on the target platform'
  homepage 'http://glew.sourceforge.net/'
  version '2.1.0'
  source_url 'https://github.com/nigels-com/glew/releases/download/glew-2.1.0/glew-2.1.0.tgz'
  source_sha256 '04de91e7e6763039bc11940095cd9c7f880baba82196a7765f727ac05a993c95'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glew-2.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glew-2.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glew-2.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glew-2.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '66d50f1b19c6a53fc3b30940df863e4471d9ee641310eef1965f69748d54fa98',
     armv7l: '66d50f1b19c6a53fc3b30940df863e4471d9ee641310eef1965f69748d54fa98',
       i686: '6cdeed1dbca32d7ca46cda937c0d5487ad2d5c2ef96916339093f838e0d0ba9e',
     x86_64: '021f5b6b7669a7719e5b46716ce3aac75c4fd1922ec4d2f112a318867665e5c8',
  })

  depends_on 'mesa'

  def self.build
    Dir.chdir 'build' do
      system 'cmake',
             '-DCMAKE_BUILD_TYPE=Release',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX}",
             './cmake'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "GLEW_DEST=#{CREW_DEST_DIR}", 'install'
    end
  end
end
