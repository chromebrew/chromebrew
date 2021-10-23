require 'package'

class Py3_sqlalchemy < Package
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  @_ver = '1.4.25'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/sqlalchemy/sqlalchemy.git'
  git_hashtag "rel_#{@_ver.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sqlalchemy/1.4.25_armv7l/py3_sqlalchemy-1.4.25-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sqlalchemy/1.4.25_armv7l/py3_sqlalchemy-1.4.25-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sqlalchemy/1.4.25_i686/py3_sqlalchemy-1.4.25-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sqlalchemy/1.4.25_x86_64/py3_sqlalchemy-1.4.25-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '3e20c495f38a606c70ac1a89fade1bc1d68e883eebbe00d88c4905419feaf397',
     armv7l: '3e20c495f38a606c70ac1a89fade1bc1d68e883eebbe00d88c4905419feaf397',
       i686: 'e3772643095d01f661b090d3d9bacc035e9be4d1a824c2e9699f5a49901ef142',
     x86_64: 'f79747695d135b6a05726184d33261bf701454631afca2cadd75011fa6014269'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
