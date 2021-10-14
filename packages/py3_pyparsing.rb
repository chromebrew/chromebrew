require 'package'

class Py3_pyparsing < Package
  description 'The pyparsing module is an alternative approach to creating and executing simple grammars, vs. the traditional lex/yacc approach, or the use of regular expressions.'
  homepage 'https://github.com/pyparsing/pyparsing/'
  @_ver = '2.4.7'
  version @_ver + '-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pyparsing/pyparsing.git'
  git_hashtag "pyparsing_#{@_ver}"

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
