require 'package'

class Py3_agate_dfb < Package
  description 'Agate-dbf adds read support for DBF files to agate.'
  homepage 'https://agate-dbf.readthedocs.org/'
  @_ver = '0.2.2'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/agate-dbf.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_dfb/0.2.2_armv7l/py3_agate_dfb-0.2.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_dfb/0.2.2_armv7l/py3_agate_dfb-0.2.2-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_dfb/0.2.2-1_i686/py3_agate_dfb-0.2.2-1-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_dfb/0.2.2-1_x86_64/py3_agate_dfb-0.2.2-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '27a3e18a7dc058d0d4381d0f95b3bd8eef1c0a43455a6394a444cb6172cbddc4',
     armv7l: '27a3e18a7dc058d0d4381d0f95b3bd8eef1c0a43455a6394a444cb6172cbddc4',
    i686: 'cf0c96a308a860ffbe0bd1039216546fa9c2410c4d7b8a702d5306c5b912d5a1',
  x86_64: 'd86b80198abc113e659bf421b9b4feef42cf63a9d5aec9850b377cb0b4ba94c7'
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
