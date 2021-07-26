require 'package'

class Py3_agate_sql < Package
  description 'Agate-sql adds SQL read/write support to agate.'
  homepage 'https://agate-sql.readthedocs.org/'
  @_ver = '0.5.7'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/agate-sql.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_sql/0.5.7_armv7l/py3_agate_sql-0.5.7-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_sql/0.5.7_armv7l/py3_agate_sql-0.5.7-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_sql/0.5.7_x86_64/py3_agate_sql-0.5.7-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '211b35ed7e9d3a484c16defcd5189657693067d4db59afa67a01189e09409411',
     armv7l: '211b35ed7e9d3a484c16defcd5189657693067d4db59afa67a01189e09409411',
     x86_64: '4e5560fbade017e6aa1e2f552e625bc9df2421ec9ca1312d69d58668e29d1995'
  })

  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
