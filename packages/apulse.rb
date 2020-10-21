require 'package'

class Apulse < Package
  description 'PulseAudio emulation for ALSA'
  homepage 'https://github.com/i-rinat/apulse'
  version '0.1.13'
  compatibility 'all'
  source_url 'https://github.com/i-rinat/apulse/archive/v0.1.13.tar.gz'
  source_sha256 '9234ec4e10e408b9c01d5f4ea768ad1fc15494217c932db2c435202a9c7b5efd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/apulse-0.1.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/apulse-0.1.13-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/apulse-0.1.13-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/apulse-0.1.13-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f5c79d86e9b448988428783b19faaf6f1d1ed3547d2ecd3667557530bb35ceda',
     armv7l: 'f5c79d86e9b448988428783b19faaf6f1d1ed3547d2ecd3667557530bb35ceda',
       i686: 'd471be802d11b38a24b55de9f6d095611e91f467c8b6850db043dab9c9ce89a6',
     x86_64: '30b5533b7da5d2aeb8be93caf3e9a02db3a2f8479634d89c3dd38a290b2b6c90',
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
