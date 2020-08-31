require 'package'

class Wpebackend_fdo < Package
  description 'General-purpose library specifically developed for the WPE-flavored port of WebKit.'
  homepage 'https://github.com/Igalia/WPEBackend-fdo'
  version '1.6.1'
  compatibility 'all'
  source_url 'https://github.com/Igalia/WPEBackend-fdo/releases/download/1.6.1/wpebackend-fdo-1.6.1.tar.xz'
  source_sha256 '740eee3327acfb462b8460519a219e30dc0a870326e88e2ddc4fe2c8de20b1c9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wpebackend_fdo-1.6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wpebackend_fdo-1.6.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wpebackend_fdo-1.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wpebackend_fdo-1.6.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b4d88634ce83f63a2ff51952f0810de5b006b7040a963d45d3365b91a5fe6e24',
     armv7l: 'b4d88634ce83f63a2ff51952f0810de5b006b7040a963d45d3365b91a5fe6e24',
       i686: '4b2fac0a52908ab4024a4c9c2b9bce413a86dcee20f9a7ef1f8fe858e4558f69',
     x86_64: '4793cf26d8d027dfb038d8e6ec16280e962c70f7472caebab690b85960d71eba',
  })

  depends_on 'libwpe'
  depends_on 'wayland'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DCMAKE_INSTALL_LIBDIR=#{ARCH_LIB}",
             '-DCMAKE_BUILD_TYPE=Release',
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
