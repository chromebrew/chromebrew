require 'package'

class Py3_sqlalchemy < Package
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  @_ver = '1.4.21'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/sqlalchemy/sqlalchemy.git'
  git_hashtag "rel_#{@_ver.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sqlalchemy/1.4.21_armv7l/py3_sqlalchemy-1.4.21-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sqlalchemy/1.4.21_armv7l/py3_sqlalchemy-1.4.21-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sqlalchemy/1.4.21_i686/py3_sqlalchemy-1.4.21-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sqlalchemy/1.4.21_x86_64/py3_sqlalchemy-1.4.21-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '075915be591aa3ef89c5a08cdd1cf8922ce97900c1fb6aeeb1da146e011b2daf',
     armv7l: '075915be591aa3ef89c5a08cdd1cf8922ce97900c1fb6aeeb1da146e011b2daf',
       i686: '4fb2f1f01451952e39e3c58ab91372d3debb0678930d7213bb4e9b27fefe7f59',
     x86_64: '99c8729d8fc8f1dcb5d1635419cc9953cee791f2443d3e6954471e26ed7c6854'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
