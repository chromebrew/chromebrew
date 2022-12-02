require 'package'

class Py3_pyparsing < Package
  description 'The pyparsing module is an alternative approach to creating and executing simple grammars, vs. the traditional lex/yacc approach, or the use of regular expressions.'
  homepage 'https://github.com/pyparsing/pyparsing/'
  @_ver = '3.0.9'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pyparsing/pyparsing.git'
  git_hashtag "pyparsing_#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/3.0.9-py3.11_armv7l/py3_pyparsing-3.0.9-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/3.0.9-py3.11_armv7l/py3_pyparsing-3.0.9-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/3.0.9-py3.11_i686/py3_pyparsing-3.0.9-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/3.0.9-py3.11_x86_64/py3_pyparsing-3.0.9-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f9b77523c088b539ed706824100f3119fc7f2d6b09ec69acc8fd5fedc7f481a2',
     armv7l: 'f9b77523c088b539ed706824100f3119fc7f2d6b09ec69acc8fd5fedc7f481a2',
       i686: '82f7f41291a85b988879a1c64f1617e0e75eba6afdf1995b7b320f17565939c8',
     x86_64: '2fc02404bd61fe6fb2cfd6c696dcd0d4d72cd58cc917820e971293d94520f396'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'

  conflicts_ok

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
