require 'buildsystems/python'

class Py3_pyparsing < Python
  description 'The pyparsing module is an alternative approach to creating and executing simple grammars, vs. the traditional lex/yacc approach, or the use of regular expressions.'
  homepage 'https://github.com/pyparsing/pyparsing/'
  @_ver = '3.1.1'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pyparsing/pyparsing.git'
  git_hashtag "pyparsing_#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/3.0.9-py3.12_armv7l/py3_pyparsing-3.0.9-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/3.0.9-py3.12_armv7l/py3_pyparsing-3.0.9-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/3.0.9-py3.12_i686/py3_pyparsing-3.0.9-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/3.0.9-py3.12_x86_64/py3_pyparsing-3.0.9-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1aefcf303baf937046b8567543c738aad4d91261674ebdc16154a8355890de8c',
     armv7l: '1aefcf303baf937046b8567543c738aad4d91261674ebdc16154a8355890de8c',
       i686: '12a1f316d390f4e5eba4d721e23ffe46badb2142127395a8f8650dbaee3f65d6',
     x86_64: 'b886898c0dc40e497b6e2b56e467c9247ab811d0ff9dc68bdd57637c23436f74'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'
end
