require 'package'

class Hunspell_en_us < Package
  description 'Hunspell US English dictionary'
  homepage 'http://hunspell.github.io/'
  version '26.8.2.2'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/LibreOffice/dictionaries.git'
  git_hashtag "libreoffice-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3a5e0a276ae81f0078fccba964d826ad555dcfa4dbdb66045c36f4c583a4dd03',
     armv7l: '3a5e0a276ae81f0078fccba964d826ad555dcfa4dbdb66045c36f4c583a4dd03',
       i686: 'daf2ab1ba6cfc02d17c666b1131f668258236eebe53801e67495223cfe522b13',
     x86_64: 'cfede0d38b5527d366ab4a9e5ac7a41d913f6e16ef2613eac37ab0d94f9e1d74'
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
