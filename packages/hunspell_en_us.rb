require 'package'

class Hunspell_en_us < Package
  description 'Hunspell US English dictionary'
  homepage 'http://hunspell.github.io/'
  version '1.7.0'
  source_url 'https://github.com/hunspell/hunspell/archive/v1.7.0.tar.gz'
  source_sha256 'bb27b86eb910a8285407cf3ca33b62643a02798cf2eef468c0a74f6c3ee6bc8a'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'hunspell'

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
