require 'package'

class Hunspell_en_us < Package
  description 'Hunspell US English dictionary'
  homepage 'http://hunspell.github.io/'
  version '1.7.0'
  compatibility 'all'
  source_url 'https://github.com/hunspell/hunspell/archive/v1.7.0.tar.gz'
  source_sha256 'bb27b86eb910a8285407cf3ca33b62643a02798cf2eef468c0a74f6c3ee6bc8a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell_en_us-1.7.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell_en_us-1.7.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell_en_us-1.7.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell_en_us-1.7.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6e1a21976f02659b1ecd7b2c4ac5b39f05798ea6f1ba0cf582fa1b24906fcaf8',
     armv7l: '6e1a21976f02659b1ecd7b2c4ac5b39f05798ea6f1ba0cf582fa1b24906fcaf8',
       i686: '5d73dad2268cd03f84cc2f11052f9e917f50d833ac06d0c5c603d70944fced3f',
     x86_64: '5ef3c02a61ed5edd4cc10020b824ea7b654a8b3eec7ec7bc6dd972c8b4188def',
  })

  depends_on 'hunspell_base'

  def self.install
    system 'git clone -b libreoffice-6-1 --depth 1 git://anongit.freedesktop.org/libreoffice/dictionaries.git'
    system "install -Dm644 dictionaries/en/en_US.aff #{CREW_DEST_HOME}/Library/Spelling/en_US.aff"
    system "install -Dm644 dictionaries/en/en_US.dic #{CREW_DEST_HOME}/Library/Spelling/en_US.dic"
  end

  def self.postinstall
    system 'git clone -b libreoffice-6-1 --depth 1 git://anongit.freedesktop.org/libreoffice/dictionaries.git'
    FileUtils.cp 'dictionaries/en/en_US.aff', "#{HOME}/Library/Spelling/en_US.aff"
    FileUtils.cp 'dictionaries/en/en_US.dic', "#{HOME}/Library/Spelling/en_US.dic"
    FileUtils.rm_rf 'dictionaries/'
    puts
    puts "To update the dictionaries periodically, execute 'crew postinstall hunspell_en_us'.".lightblue
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo 'export DICTIONARY=en_US' >> ~/.bashrc && source ~/.bashrc".lightblue
    puts
  end
end
