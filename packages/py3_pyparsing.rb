require 'package'

class Py3_pyparsing < Package
  description 'The pyparsing module is an alternative approach to creating and executing simple grammars, vs. the traditional lex/yacc approach, or the use of regular expressions.'
  homepage 'https://github.com/pyparsing/pyparsing/'
  @_ver = '2.4.7'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pyparsing/pyparsing.git'
  git_hashtag "pyparsing_#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/2.4.7_armv7l/py3_pyparsing-2.4.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/2.4.7_armv7l/py3_pyparsing-2.4.7-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/2.4.7_i686/py3_pyparsing-2.4.7-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/2.4.7_x86_64/py3_pyparsing-2.4.7-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'cd2141e4eb353cde5a30ef4445ff513d5b8733e864e24b4f8c88c2073d300f47',
     armv7l: 'cd2141e4eb353cde5a30ef4445ff513d5b8733e864e24b4f8c88c2073d300f47',
       i686: 'd6ee1ae8508b1147e651d9cfb5c2c075a51f06d8dd6bf00019589df92df9df95',
     x86_64: '1bd47b7bb7c75d0bc12e65038eea0aaae21d504a656e52298758d839731f2628'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
