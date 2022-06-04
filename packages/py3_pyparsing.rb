require 'package'

class Py3_pyparsing < Package
  description 'The pyparsing module is an alternative approach to creating and executing simple grammars, vs. the traditional lex/yacc approach, or the use of regular expressions.'
  homepage 'https://github.com/pyparsing/pyparsing/'
  @_ver = '3.0.9'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pyparsing/pyparsing.git'
  git_hashtag "pyparsing_#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/3.0.9-1_armv7l/py3_pyparsing-3.0.9-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/3.0.9-1_armv7l/py3_pyparsing-3.0.9-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/3.0.9-1_i686/py3_pyparsing-3.0.9-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/3.0.9-1_x86_64/py3_pyparsing-3.0.9-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1d699410ff0ce5fd1ffd04e0821c6f4cf40c1ba121e068667c10c54aec6e9988',
     armv7l: '1d699410ff0ce5fd1ffd04e0821c6f4cf40c1ba121e068667c10c54aec6e9988',
       i686: '58120f6c525c5948122d0e3667d84a7a525c8ff41b09ba85529a756c3bae0775',
     x86_64: '0570ed48a42e9a30e2587f3384ab3468a9280e06433658d00f0cdd9578326633'
  })

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
