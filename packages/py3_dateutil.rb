require 'package'

class Py3_dateutil < Package
  description 'Dateutil provides extensions to the standard Python datetime module.'
  homepage 'https://dateutil.readthedocs.io/'
  @_ver = '2.8.1'
  version @_ver
  license 'BSD-3 and Apache-2.0 or BSD-3'
  compatibility 'all'
  source_url 'https://github.com/dateutil/dateutil.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dateutil/2.8.1_armv7l/py3_dateutil-2.8.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dateutil/2.8.1_armv7l/py3_dateutil-2.8.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dateutil/2.8.1_x86_64/py3_dateutil-2.8.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '69b12966a2d83315df429beb76465ac13a32ff82749c86afe3eb71e0213ff873',
     armv7l: '69b12966a2d83315df429beb76465ac13a32ff82749c86afe3eb71e0213ff873',
     x86_64: '626496d05853a5734262d7a2f44289effeaa3573b9a44dfc9e32ca5a7c624131'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
