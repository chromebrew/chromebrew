require 'package'

class Hunspell_fr_fr < Package
  description 'Hunspell French dictionary'
  homepage 'http://hunspell.github.io/'
  version '1.7.0-2'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/hunspell/hunspell/archive/v1.7.0.tar.gz'
  source_sha256 'bb27b86eb910a8285407cf3ca33b62643a02798cf2eef468c0a74f6c3ee6bc8a'

  depends_on 'hunspell_base'

  def self.install
    system 'git clone -b libreoffice-6-1 --depth 1 git://anongit.freedesktop.org/libreoffice/dictionaries.git'
    system "install -Dm644 dictionaries/fr_FR/fr.aff #{CREW_DEST_HOME}/Library/Spelling/fr_FR.aff"
    system "install -Dm644 dictionaries/fr_FR/fr.dic #{CREW_DEST_HOME}/Library/Spelling/fr_FR.dic"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # Configuración de hunspell
      export DICTIONARY=fr_FR
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/hunspell_fr_fr", @env)
  end

  def self.postinstall
    system 'git clone -b libreoffice-6-1 --depth 1 git://anongit.freedesktop.org/libreoffice/dictionaries.git'
    FileUtils.cp 'dictionaries/fr_FR/fr.aff', "#{HOME}/Library/Spelling/fr_FR.aff"
    FileUtils.cp 'dictionaries/fr_FR/fr.dic', "#{HOME}/Library/Spelling/fr_FR.dic"
    FileUtils.rm_rf 'dictionaries/'
    puts
    puts "To update the dictionaries periodically, execute 'crew postinstall hunspell_fr_fr'".lightblue
    puts
  end
end
