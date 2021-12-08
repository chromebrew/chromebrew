require 'package'

class Py3_agate_sql < Package
  description 'Agate-sql adds SQL read/write support to agate.'
  homepage 'https://agate-sql.readthedocs.org/'
  @_ver = '0.5.8'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/agate-sql.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_sql/0.5.8_armv7l/py3_agate_sql-0.5.8-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_sql/0.5.8_armv7l/py3_agate_sql-0.5.8-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_sql/0.5.8_i686/py3_agate_sql-0.5.8-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_sql/0.5.8_x86_64/py3_agate_sql-0.5.8-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6c5754f93292e168e09d476a81e501eaf3a12949b72be2b4a71a30681d209e8f',
     armv7l: '6c5754f93292e168e09d476a81e501eaf3a12949b72be2b4a71a30681d209e8f',
       i686: 'efd1f5a6bbec27206a296180059a306f16660de872f59ae0bde97bf870b87ffe',
     x86_64: 'a7a2ec511e4cedb249d0d9585d9bc7129cb5b434004553608a18d88c3ff52496'
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
