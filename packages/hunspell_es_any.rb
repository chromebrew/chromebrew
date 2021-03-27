require 'package'

class Hunspell_es_any < Package
  description 'Diccionarios de español de Hunspell'
  homepage 'http://hunspell.github.io/'
  version '1.7.0-1'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/hunspell/hunspell/archive/v1.7.0.tar.gz'
  source_sha256 'bb27b86eb910a8285407cf3ca33b62643a02798cf2eef468c0a74f6c3ee6bc8a'

  depends_on 'hunspell_base'

  def self.install
    system 'git clone -b libreoffice-6-1 --depth 1 git://anongit.freedesktop.org/libreoffice/dictionaries.git'
    system "install -Dm644 dictionaries/es/es_ANY.aff #{CREW_DEST_HOME}/Library/Spelling/es_ANY.aff"
    system "install -Dm644 dictionaries/es/es_ANY.dic #{CREW_DEST_HOME}/Library/Spelling/es_ANY.dic"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # Configuración de hunspell
      export DICTIONARY=es_ANY
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/hunspell_es_any", @env)
  end

  def self.postinstall
    system 'git clone -b libreoffice-6-1 --depth 1 git://anongit.freedesktop.org/libreoffice/dictionaries.git'
    FileUtils.cp 'dictionaries/es/es_ANY.aff', "#{HOME}/Library/Spelling/es_ANY.aff"
    FileUtils.cp 'dictionaries/es/es_ANY.dic', "#{HOME}/Library/Spelling/es_ANY.dic"
    FileUtils.rm_rf 'dictionaries/'
    puts
    puts "Para actualizar los diccionarios periódicamente, ejecute 'crew postinstall hunspell_es_any'".lightblue
    puts
  end
end
