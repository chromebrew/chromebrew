require 'package'

class Hunspell_fr_fr < Package
  description 'Hunspell French dictionary'
  homepage 'http://hunspell.github.io/'
  version '1.7.0'
  source_url 'https://github.com/hunspell/hunspell/archive/v1.7.0.tar.gz'
  source_sha256 'bb27b86eb910a8285407cf3ca33b62643a02798cf2eef468c0a74f6c3ee6bc8a'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'hunspell_base'

  def self.install
    system 'git clone -b libreoffice-6-1 --depth 1 git://anongit.freedesktop.org/libreoffice/dictionaries.git'
    system "install -Dm644 dictionaries/fr_FR/fr.aff #{CREW_DEST_HOME}/Library/Spelling/fr_FR.aff"
    system "install -Dm644 dictionaries/fr_FR/fr.dic #{CREW_DEST_HOME}/Library/Spelling/fr_FR.dic"
  end

  def self.postinstall
    system 'git clone -b libreoffice-6-1 --depth 1 git://anongit.freedesktop.org/libreoffice/dictionaries.git'
    FileUtils.cp 'dictionaries/fr_FR/fr.aff', "#{HOME}/Library/Spelling/fr_FR.aff"
    FileUtils.cp 'dictionaries/fr_FR/fr.dic', "#{HOME}/Library/Spelling/fr_FR.dic"
    FileUtils.rm_rf 'dictionaries/'
    puts
    puts "To update the dictionaries periodically, execute 'crew postinstall hunspell_fr_fr'".lightblue
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo 'export DICTIONARY=fr_FR' >> ~/.bashrc && source ~/.bashrc".lightblue
    puts
  end
end
