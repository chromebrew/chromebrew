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
    aarch64: '5c84dec013f9409d5ddad79f5c4034c10541926dde48d5848d946284b2aacb12',
     armv7l: '5c84dec013f9409d5ddad79f5c4034c10541926dde48d5848d946284b2aacb12',
       i686: 'c084beab43308489cdc1f2814776354e5d2b94c680e7c75ceccf330945747659',
     x86_64: '10addc1059f3399f556b9ee9b6b2206abf8c0131ec74ec853465032274acbce9'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
