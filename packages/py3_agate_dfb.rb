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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_dfb/0.2.2-1_armv7l/py3_agate_dfb-0.2.2-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_dfb/0.2.2-1_armv7l/py3_agate_dfb-0.2.2-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_dfb/0.2.2-1_i686/py3_agate_dfb-0.2.2-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_dfb/0.2.2-1_x86_64/py3_agate_dfb-0.2.2-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '59df28fe1a1b6b48ab0bbde213920b619244e189d0cbfdea27768f88fbe67a65',
     armv7l: '59df28fe1a1b6b48ab0bbde213920b619244e189d0cbfdea27768f88fbe67a65',
       i686: 'a25fffa3151ed005f3c9f975d44bf0774604cfa4fa4f1bc2b50f893362dfb195',
     x86_64: '1ecddc4169dd1ba4f3d3c025e19cb32d3e580c8334c98ba5f1a77fb4a9fec09e'
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
