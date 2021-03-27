require 'package'

class Hunspell_en_us < Package
  description 'Hunspell US English dictionary'
  homepage 'http://hunspell.github.io/'
  version '1.7.0-1'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/hunspell/hunspell/archive/v1.7.0.tar.gz'
  source_sha256 'bb27b86eb910a8285407cf3ca33b62643a02798cf2eef468c0a74f6c3ee6bc8a'

  depends_on 'hunspell_base'

  def self.install
    system 'git clone -b libreoffice-6-1 --depth 1 git://anongit.freedesktop.org/libreoffice/dictionaries.git'
    system "install -Dm644 dictionaries/en/en_US.aff #{CREW_DEST_HOME}/Library/Spelling/en_US.aff"
    system "install -Dm644 dictionaries/en/en_US.dic #{CREW_DEST_HOME}/Library/Spelling/en_US.dic"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # American English hunspell configuration
      export DICTIONARY=en_US
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/hunspell_en_us", @env)
  end

  def self.postinstall
    # This willbe a cron job later
    system 'git clone -b libreoffice-6-1 --depth 1 git://anongit.freedesktop.org/libreoffice/dictionaries.git'
    FileUtils.cp 'dictionaries/en/en_US.aff', "#{HOME}/Library/Spelling/en_US.aff"
    FileUtils.cp 'dictionaries/en/en_US.dic', "#{HOME}/Library/Spelling/en_US.dic"
    FileUtils.rm_rf 'dictionaries/'
    puts
    puts "To update the dictionaries periodically, execute 'crew postinstall hunspell_en_us'.".lightblue
    puts
  end
end
