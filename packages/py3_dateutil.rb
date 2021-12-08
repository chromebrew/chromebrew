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
    aarch64: '3e0b6fccb5e0a5392dd966ef5c5e4064a8e5c1d5c37f5a5437a14a5cb947df09',
     armv7l: '3e0b6fccb5e0a5392dd966ef5c5e4064a8e5c1d5c37f5a5437a14a5cb947df09',
       i686: 'cee2ce8239781a92571442a900c96904830ef997cd80986719fb403c59a27256',
     x86_64: '7543e7f881e5673223024757febd5a35aa59664946ef249368e1fb85164c4053'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
