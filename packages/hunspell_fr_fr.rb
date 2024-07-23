require 'package'

class Hunspell_fr_fr < Package
  description 'Dictionnaire Français Hunspell'
  homepage 'http://hunspell.github.io/'
  version '1.7.0-2'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/hunspell/hunspell/archive/v1.7.0.tar.gz'
  source_sha256 'bb27b86eb910a8285407cf3ca33b62643a02798cf2eef468c0a74f6c3ee6bc8a'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'f9436296b3b3cc53ed1307e21493754054037fa4ee69e8d047316d7d9906ce07',
     armv7l: 'f9436296b3b3cc53ed1307e21493754054037fa4ee69e8d047316d7d9906ce07',
       i686: '3d3d35a011256158f200ea5761ac3562f534733865a03c6f1023284e79235bca',
     x86_64: 'aea9ec478d565bb9b240157630ae265e11f108652293131b439c8bf43ed546b9'
  })

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
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/hunspell_fr_fr", @env)
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
