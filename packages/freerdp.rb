require 'package'

class Freerdp < Package
  description 'FreeRDP is a free implementation of the Remote Desktop Protocol.'
  homepage 'https://www.freerdp.com/'
  version '2.0.0-rc4-1'
  compatibility 'all'
  source_url 'https://github.com/FreeRDP/FreeRDP/archive/2.0.0-rc4.tar.gz'
  source_sha256 '3406f3bfab63f81c1533029a5bf73949ff60f22f6e155c5a08005b8b8afe6d49'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/freerdp-2.0.0-rc4-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/freerdp-2.0.0-rc4-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/freerdp-2.0.0-rc4-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/freerdp-2.0.0-rc4-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '47473dda58b59aa8e278b695c12d0639638e6071a856e1acc27f1abcda8ef3ca',
     armv7l: '47473dda58b59aa8e278b695c12d0639638e6071a856e1acc27f1abcda8ef3ca',
       i686: '93612031e2fbddcc09ce7338a631783b39c7518946b9d8ee09b148c7774ed93c',
     x86_64: 'a029e77ed6c8d47ebcd7c74a8b1430b158f6ebdb04384697abe7c8da613526cf',
  })

  depends_on 'cups'
  depends_on 'xmlto'
  depends_on 'xprop'
  depends_on 'ffmpeg'
  depends_on 'linux_pam'
  depends_on 'gst_plugins_base'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.build
    FileUtils.mkdir('build')
    Dir.chdir('build') do
      ENV['GSS_ROOT_FLAVOUR'] = 'MIT'
      system 'cmake',
             "-DDOCBOOKXSL_DIR=#{CREW_PREFIX}/share/xml/xsl-stylesheets-1.79.2",
             "-DCMAKE_INSTALL_PREFIX:PATH=#{CREW_PREFIX}",
             '-DBUILD_SHARED_LIBS=ON',
             '-DWITH_LIBSYSTEMD=OFF',
             '-DWITH_DSP_FFMPEG=yes',
             '-DWITH_CHANNELS=ON',
             '-DWITH_SERVER=ON',
             '-DWITH_CLIENT=ON',
             '-DWITH_GSSAPI=ON',
             '-GUnix Makefiles',
             '-DWITH_PULSE=ON',
             '-DWITH_CUPS=ON',
             '-DWITH_SOXR=ON',
             '-DWITH_LAME=ON',
             '-DWITH_JPEG=ON',
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir('build') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end

  def self.postinstall
    puts
    puts 'To test this package, try the following command to connect to the Windows server at https://www.secure-od.com/:'.lightblue
    puts 'xfreerdp -g 800x600 -u demo2 -p D3m02014*Test 109.168.97.222'.lightblue
    puts 'If you don\'t have the Sommelier daemon running, you may need to prepend that with "sommelier -X ".'.lightblue
    puts
  end
end
