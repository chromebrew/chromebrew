require 'package'

class Hunspell_en_us < Package
  description 'Hunspell US English dictionary'
  homepage 'http://hunspell.github.io/'
  version '26.2.2.2'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e1e3e2ea5803b67aa1cce2d46dd1a60f01b0383942e322eb8325c5edae658ccb',
     armv7l: 'e1e3e2ea5803b67aa1cce2d46dd1a60f01b0383942e322eb8325c5edae658ccb',
       i686: 'e2acdc73081b7d9269c8c523dfb58818fafc345f1356a8902f68fe36371c85db',
     x86_64: 'b8f55c4a8c205949a16b0354c7b594817494cbaee8ccfa3471b3a578edd8259f'
  })

  depends_on 'hunspell_base'

  def self.install
    FileUtils.install 'en/en_US.aff', "#{CREW_DEST_HOME}/Library/Spelling/en_US.aff", mode: 0o644
    FileUtils.install 'en/en_US.dic', "#{CREW_DEST_HOME}/Library/Spelling/en_US.dic", mode: 0o644

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/hunspell_en_us", <<~EOF
      # American English hunspell configuration
      export DICTIONARY=en_US
    EOF
  end
end
