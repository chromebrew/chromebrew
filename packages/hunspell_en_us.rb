require 'package'

class Hunspell_en_us < Package
  description 'Hunspell US English dictionary'
  homepage 'http://hunspell.github.io/'
  version '1.7.0-1'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/hunspell/hunspell/archive/v1.7.0.tar.gz'
  source_sha256 'bb27b86eb910a8285407cf3ca33b62643a02798cf2eef468c0a74f6c3ee6bc8a'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '5533a1b89550da537e9243cab913e51f8736218e1163773a147cadb78626f279',
     armv7l: '5533a1b89550da537e9243cab913e51f8736218e1163773a147cadb78626f279',
       i686: '1ce9ea2baaab15b09c72e2ce7ce6af118a0ab6d7777e874d26770ea8c8175750',
     x86_64: '254be4f7588feb30908fd02d86e88ea75284ab1188d5dce2605425179b681919'
  })

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
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/hunspell_en_us", @env)
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
