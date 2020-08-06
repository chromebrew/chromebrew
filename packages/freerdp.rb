require 'package'

class Freerdp < Package
  description 'FreeRDP is a free implementation of the Remote Desktop Protocol.'
  homepage 'https://www.freerdp.com/'
  version '2.2.0'
  compatibility 'all'
  source_url 'https://github.com/FreeRDP/FreeRDP/archive/2.2.0.tar.gz'
  source_sha256 '883bc0396c6be9aba6bc07ebc8ff08457125868ada0f06554e62ef072f90cf59'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/freerdp-2.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/freerdp-2.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/freerdp-2.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/freerdp-2.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'de7c23e9ddeed50896daed5081a2aaf8fb849799faee83155d2a32939abbf6a7',
     armv7l: 'de7c23e9ddeed50896daed5081a2aaf8fb849799faee83155d2a32939abbf6a7',
       i686: '860fe130e143159c859d7adfe872c305de6a3a17a5d06becbeb86c191ae9320b',
     x86_64: 'c10b462dee10090118d9bfd676d591512f90e6e1cbf9a678c7d5869a6bb3adfc',
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
