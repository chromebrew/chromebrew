require 'package'

class Freerdp < Package
  description 'FreeRDP is a free implementation of the Remote Desktop Protocol.'
  homepage 'http://www.freerdp.com/'
  version '2.0.0-rc4'
  source_url 'https://github.com/FreeRDP/FreeRDP/archive/2.0.0-rc4.tar.gz'
  source_sha256 '3406f3bfab63f81c1533029a5bf73949ff60f22f6e155c5a08005b8b8afe6d49'

  depends_on 'alsa_lib'
  depends_on 'ffmpeg'
  depends_on 'gst_plugins_base'
  depends_on 'cups'
  depends_on 'pulseaudio'
  depends_on 'cmake' => :build
  depends_on 'xmlto'
  depends_on 'ninja'
  depends_on 'sommelier'

  def self.build
    system 'cmake', "-DCMAKE_INSTALL_PREFIX:PATH=#{CREW_DEST_PREFIX}", '.'
    system 'cmake', '--build', '.'
  end

  def self.install
    system 'cmake', '--build', '.', '--target', 'install'
  end

  def self.postinstall
    puts 'To test this package, try the following command to connect to the Windows server at https://www.secure-od.com/:'.lightblue
    puts 'xfreerdp -g 800x600 -u demo2 -p D3m02014*Test 109.168.97.222'.lightblue
    puts 'If you don\'t have the Sommelier daemon running, you may need to prepend that with "sommelier -X ".'.lightblue
  end
end
