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
    aarch64: 'a8fded909be7abd312b0ac3982fab1761866fd57b4251d0dd2985684fe53bb03',
     armv7l: 'a8fded909be7abd312b0ac3982fab1761866fd57b4251d0dd2985684fe53bb03',
       i686: '20db00d26dcb4428bd34a38114a43dbdff5b61c9a84704f8982091e751a036a9',
     x86_64: '3e1b0d1118f9cd2f9c8bcc0d27c432a1fbd8dcf13992e3bebe15f0f64e1ce59c'
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
