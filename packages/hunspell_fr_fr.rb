require 'package'

class Hunspell_fr_fr < Package
  description 'Hunspell French dictionary'
  homepage 'http://hunspell.github.io/'
  version '1.7.0'
  compatibility 'all'
  source_url 'https://github.com/hunspell/hunspell/archive/v1.7.0.tar.gz'
  source_sha256 'bb27b86eb910a8285407cf3ca33b62643a02798cf2eef468c0a74f6c3ee6bc8a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell_fr_fr-1.7.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell_fr_fr-1.7.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell_fr_fr-1.7.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell_fr_fr-1.7.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bd10e474d96b5a3c8ff0085fdbae104099d7d11b1591b48dd6918506a1de4bf0',
     armv7l: 'bd10e474d96b5a3c8ff0085fdbae104099d7d11b1591b48dd6918506a1de4bf0',
       i686: '50a195c7cddf14f0a15cb8cf73e3ed98219a1de46ed6f5470176c443899a4034',
     x86_64: 'ebb968ba879d0e14497b79f6d4156b82d5d2ee18080fd1e4a5fc5eb709c45f50',
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
