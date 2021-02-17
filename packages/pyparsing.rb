require 'package'

class Pyparsing < Package
  description 'The pyparsing module is an alternative approach to creating and executing simple grammars, vs. the traditional lex/yacc approach, or the use of regular expressions.'
  homepage 'https://github.com/pyparsing/pyparsing'
  version '2.4.7'
  compatibility 'all'
  source_url 'https://github.com/pyparsing/pyparsing/releases/download/pyparsing_2.4.7/pyparsing-2.4.7.tar.gz'
  source_sha256 'c203ec8783bf771a155b207279b9bccb8dea02d8f0c9e5f8ead507bc3246ecc1'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pyparsing-2.4.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pyparsing-2.4.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pyparsing-2.4.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pyparsing-2.4.7-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd4decc10bf590b30f6c05fb463e7fc9d79b7d9e9d84a92de694619ba10da0381',
     armv7l: 'd4decc10bf590b30f6c05fb463e7fc9d79b7d9e9d84a92de694619ba10da0381',
       i686: '8bf0da6c070cd6b6273b0d75078cd22264031a270b068d48d4eb120251f662a1',
     x86_64: '82bd555e8dca145d04a4db65548a711c088d8d9c6e6cee62b2d7931da240e19f'
  })

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I pyparsing==#{version}"
    system "pip3 install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I pyparsing==#{version}"
  end
end
