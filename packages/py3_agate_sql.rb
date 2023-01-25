require 'package'

class Py3_agate_sql < Package
  description 'Agate-sql adds SQL read/write support to agate.'
  homepage 'https://agate-sql.readthedocs.org/'
  @_ver = '0.5.8'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/agate-sql.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_sql/0.5.8-py3.11_armv7l/py3_agate_sql-0.5.8-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_sql/0.5.8-py3.11_armv7l/py3_agate_sql-0.5.8-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_sql/0.5.8-py3.11_i686/py3_agate_sql-0.5.8-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_sql/0.5.8-py3.11_x86_64/py3_agate_sql-0.5.8-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '93364ad5859fe10567bcdf106369883abe63a3e0bf22b0dd7aad8bfbea00dcc3',
     armv7l: '93364ad5859fe10567bcdf106369883abe63a3e0bf22b0dd7aad8bfbea00dcc3',
       i686: '64e29cf1b7b62dfb70f100ba38252545f3dbcab04f3829f7fd160ad5eadabb99',
     x86_64: 'fa0e99f692aed25314df94ad5a7776859a150268d893eac9231f770a6f86cc7f'
  })

  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
