require 'package'

class Pyparsing < Package
  description 'The pyparsing module is an alternative approach to creating and executing simple grammars, vs. the traditional lex/yacc approach, or the use of regular expressions.'
  homepage 'https://github.com/pyparsing/pyparsing'
  version '2.4.7'
  compatibility 'all'
  source_url 'https://github.com/pyparsing/pyparsing/releases/download/pyparsing_2.4.7/pyparsing-2.4.7.tar.gz'
  source_sha256 'c203ec8783bf771a155b207279b9bccb8dea02d8f0c9e5f8ead507bc3246ecc1'


  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I pyparsing==#{version}"
  end
end
