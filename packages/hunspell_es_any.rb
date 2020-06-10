require 'package'

class Hunspell_es_any < Package
  description 'Hunspell Spanish dictionary'
  homepage 'http://hunspell.github.io/'
  version '1.7.0'
  compatibility 'all'
  source_url 'https://github.com/hunspell/hunspell/archive/v1.7.0.tar.gz'
  source_sha256 'bb27b86eb910a8285407cf3ca33b62643a02798cf2eef468c0a74f6c3ee6bc8a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell_es_any-1.7.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell_es_any-1.7.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell_es_any-1.7.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell_es_any-1.7.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '910ae757e555654eda6b36fd90ba51a14122c4766236ec686311f19751c249b1',
     armv7l: '910ae757e555654eda6b36fd90ba51a14122c4766236ec686311f19751c249b1',
       i686: '142e9aab8a3b5be1e1e791fce20e1b4e38feae6ee0e3acd30644975a4323f924',
     x86_64: '85aadc212025474ef99365c6227d7ac417c906c8406b012839327a5da39171fe',
  })

  depends_on 'hunspell_base'

  def self.install
    system 'git clone -b libreoffice-6-1 --depth 1 git://anongit.freedesktop.org/libreoffice/dictionaries.git'
    system "install -Dm644 dictionaries/es/es_ANY.aff #{CREW_DEST_HOME}/Library/Spelling/es_ANY.aff"
    system "install -Dm644 dictionaries/es/es_ANY.dic #{CREW_DEST_HOME}/Library/Spelling/es_ANY.dic"
  end

  def self.postinstall
    system 'git clone -b libreoffice-6-1 --depth 1 git://anongit.freedesktop.org/libreoffice/dictionaries.git'
    FileUtils.cp 'dictionaries/es/es_ANY.aff', "#{HOME}/Library/Spelling/es_ANY.aff"
    FileUtils.cp 'dictionaries/es/es_ANY.dic', "#{HOME}/Library/Spelling/es_ANY.dic"
    FileUtils.rm_rf 'dictionaries/'
    puts
    puts "To update the dictionaries periodically, execute 'crew postinstall hunspell_es_any'".lightblue
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo 'export DICTIONARY=es_ANY' >> ~/.bashrc && source ~/.bashrc".lightblue
    puts
  end
end
