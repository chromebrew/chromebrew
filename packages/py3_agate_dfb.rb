require 'package'

class Py3_agate_dfb < Package
  description 'Agate-dbf adds read support for DBF files to agate.'
  homepage 'https://agate-dbf.readthedocs.org/'
  @_ver = '0.2.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/agate-dbf.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_dfb/0.2.2_armv7l/py3_agate_dfb-0.2.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_dfb/0.2.2_armv7l/py3_agate_dfb-0.2.2-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_dfb/0.2.2_x86_64/py3_agate_dfb-0.2.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '27a3e18a7dc058d0d4381d0f95b3bd8eef1c0a43455a6394a444cb6172cbddc4',
     armv7l: '27a3e18a7dc058d0d4381d0f95b3bd8eef1c0a43455a6394a444cb6172cbddc4',
     x86_64: '2395c81b46a6a6e5d05ce0edc65ad9c4c5ec87f67a10b031683f534ddfd06572'
  })

  depends_on 'py3_dbfread'
  depends_on 'py3_agate'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
