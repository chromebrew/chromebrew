require 'package'

class Py3_pyparsing < Package
  description 'The pyparsing module is an alternative approach to creating and executing simple grammars, vs. the traditional lex/yacc approach, or the use of regular expressions.'
  homepage 'https://github.com/pyparsing/pyparsing/'
  @_ver = '2.4.7'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pyparsing/pyparsing.git'
  git_hashtag "pyparsing_#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/2.4.7-1_armv7l/py3_pyparsing-2.4.7-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/2.4.7-1_armv7l/py3_pyparsing-2.4.7-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/2.4.7-1_i686/py3_pyparsing-2.4.7-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/2.4.7-1_x86_64/py3_pyparsing-2.4.7-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8dfed95736f2068caf186fb825f28c5ae6983fcd6cf0c445a70b3328be48fedc',
     armv7l: '8dfed95736f2068caf186fb825f28c5ae6983fcd6cf0c445a70b3328be48fedc',
       i686: 'eb1a938ff090d970fe237c5e31b08220941e685c7a4ae33e48f847a7ca42eece',
     x86_64: '854349095b067a3bba4c7971098f34ec099ffd64808c4bf5bd7f14c8f6ba7b8a'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
