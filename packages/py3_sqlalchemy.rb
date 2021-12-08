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
    aarch64: '1c25a187b6c3ec07bfc0193df23ceddea968da784aac9256d9d9e14045e5b5ec',
     armv7l: '1c25a187b6c3ec07bfc0193df23ceddea968da784aac9256d9d9e14045e5b5ec',
       i686: 'a06f25d8971946cc8875e9549385ad4f9e115f694e8414f4d844b8400b217334',
     x86_64: '91a17d65451620e39335a9332be1f7cf8998d40c243e69af29ee3fff5e940165'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
