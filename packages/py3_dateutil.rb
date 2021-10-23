require 'package'

class Py3_dateutil < Package
  description 'Dateutil provides extensions to the standard Python datetime module.'
  homepage 'https://dateutil.readthedocs.io/'
  @_ver = '2.8.2'
  version @_ver
  license 'BSD-3 and Apache-2.0 or BSD-3'
  compatibility 'all'
  source_url 'https://github.com/dateutil/dateutil.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dateutil/2.8.2_armv7l/py3_dateutil-2.8.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dateutil/2.8.2_armv7l/py3_dateutil-2.8.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dateutil/2.8.2_i686/py3_dateutil-2.8.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dateutil/2.8.2_x86_64/py3_dateutil-2.8.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f2c1f481627b65f75227a05fd3438a0151e5c98eb6325f3e0e34ebde65c88712',
     armv7l: 'f2c1f481627b65f75227a05fd3438a0151e5c98eb6325f3e0e34ebde65c88712',
       i686: '812bdd90d232df088fece4979cbdc5c62d66a803b88437851df124c202658bd7',
     x86_64: '8573d7017a486cbcbbb22d6062487f3db58a14f99b762756e3ec6c225e8002d7'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
