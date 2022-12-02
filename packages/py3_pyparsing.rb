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
    aarch64: '939e0032145745843ca76b98e80e2f1fdb2747ed6fd9789e6bf92454eccb29ce',
     armv7l: '939e0032145745843ca76b98e80e2f1fdb2747ed6fd9789e6bf92454eccb29ce',
       i686: 'ffc073d888b238111adaaf1c7c9d87057cc6c7e53cd04972be0777cf446fd202',
     x86_64: 'ed9b21c9b56086df2f7d8f31c3b6b7c5c9b2a6669140f2ef30c7c644c3334f79'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
