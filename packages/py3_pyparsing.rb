require 'package'

class Py3_pyparsing < Package
  description 'The pyparsing module is an alternative approach to creating and executing simple grammars, vs. the traditional lex/yacc approach, or the use of regular expressions.'
  homepage 'https://github.com/pyparsing/pyparsing/'
  @_ver = '3.0.9'
  version "#{@_ver}-py3.11-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pyparsing/pyparsing.git'
  git_hashtag "pyparsing_#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/3.0.9-py3.11-1_armv7l/py3_pyparsing-3.0.9-py3.11-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/3.0.9-py3.11-1_armv7l/py3_pyparsing-3.0.9-py3.11-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/3.0.9-py3.11-1_i686/py3_pyparsing-3.0.9-py3.11-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyparsing/3.0.9-py3.11-1_x86_64/py3_pyparsing-3.0.9-py3.11-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fa3ace7330aadc1607fc5963121a5cb99fbe64872985635557502706571e5bcb',
     armv7l: 'fa3ace7330aadc1607fc5963121a5cb99fbe64872985635557502706571e5bcb',
       i686: 'd0dd29348de1376366c2baaf2771aef5a9dc21fd1f156e5619d2596940400be1',
     x86_64: '5d0bfcea1cd42f37089de37c22441125a05d171bbda2ffba02a3bf6acfcf262b'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'
  depends_on 'py3_pep517' => :build

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
