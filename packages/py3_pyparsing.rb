require 'package'

class Py3_pyparsing < Package
  description 'The pyparsing module is an alternative approach to creating and executing simple grammars, vs. the traditional lex/yacc approach, or the use of regular expressions.'
  homepage 'https://github.com/pyparsing/pyparsing/'
  version '2.4.7-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pyparsing/pyparsing/releases/download/pyparsing_2.4.7/pyparsing-2.4.7.tar.gz'
  source_sha256 'c203ec8783bf771a155b207279b9bccb8dea02d8f0c9e5f8ead507bc3246ecc1'

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
