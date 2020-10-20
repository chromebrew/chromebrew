require 'package'

class Apulse < Package
  description 'PulseAudio emulation for ALSA'
  homepage 'https://github.com/i-rinat/apulse'
  version '0.1.13'
  compatibility 'all'
  source_url 'https://github.com/i-rinat/apulse/archive/v0.1.13.tar.gz'
  source_sha256 '9234ec4e10e408b9c01d5f4ea768ad1fc15494217c932db2c435202a9c7b5efd'

  binary_url ({
  })
  binary_sha256 ({
  })


  depends_on 'alsa_lib'
  depends_on 'alsa_plugins'
  depends_on 'glib'

  def self.build
    FileUtils.mkdir_p 'build'
    FileUtils.cd('build') do
      system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_BUILD_TYPE=Release .."
      system 'make'
      system "echo 'pcm.plugdmix {' > asoundrc"
      system "echo '  type plug' >> asoundrc"
      system "echo '  slave.pcm \"dmix\"' >> asoundrc"
      system "echo '}' >> asoundrc"
    end
  end

  def self.install
    FileUtils.cd('build') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      system "install -Dm755 asoundrc ~/.asoundrc"
    end
  end

  def self.postinstall
    puts "To use apulse, please run the following lines :".lightblue
    puts "echo 'export APULSE_PLAYBACK_DEVICE=plugdmix' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
  end
end
