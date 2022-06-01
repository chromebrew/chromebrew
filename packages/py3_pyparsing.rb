require 'package'

class Py3_pyparsing < Package
  description 'The pyparsing module is an alternative approach to creating and executing simple grammars, vs. the traditional lex/yacc approach, or the use of regular expressions.'
  homepage 'https://github.com/pyparsing/pyparsing/'
  @_ver = '3.0.9'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pyparsing/pyparsing.git'
  git_hashtag "pyparsing_#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/3.0.9_armv7l/py3_pyparsing-3.0.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/3.0.9_armv7l/py3_pyparsing-3.0.9-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/3.0.9_i686/py3_pyparsing-3.0.9-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/3.0.9_x86_64/py3_pyparsing-3.0.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '260491f085b29afd3337a19ed3b6799f209e8ef902a0dc378524617518b50432',
     armv7l: '260491f085b29afd3337a19ed3b6799f209e8ef902a0dc378524617518b50432',
       i686: 'c0b44b7b246de089e25f55dbea208910a4489565af2f0d694435fdd49aad647a',
     x86_64: 'a198eb924014106ccb4577cd3bb4d55be6123c303eb4a445535d2cde488ea694'
  })

  def self.build
    system "python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
