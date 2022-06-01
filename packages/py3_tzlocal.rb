require 'package'

class Py3_tzlocal < Package
  description 'Tzlocal provides tzinfo object for the local timezone.'
  homepage 'https://github.com/regebro/tzlocal/'
  @_ver = '4.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/regebro/tzlocal.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tzlocal/4.1_armv7l/py3_tzlocal-4.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tzlocal/4.1_armv7l/py3_tzlocal-4.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tzlocal/4.1_i686/py3_tzlocal-4.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tzlocal/4.1_x86_64/py3_tzlocal-4.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e96425974adaae83496e33c637a5e6d339c790d70c07349c7f36a84f2d9031c0',
     armv7l: 'e96425974adaae83496e33c637a5e6d339c790d70c07349c7f36a84f2d9031c0',
       i686: 'dff4f395c6278872e72c793108a6569ee480d8be741d46fe7fc2e64544878358',
     x86_64: '06acf2a698b9af8b14b7c4f67c013c06771edb8ef93778b0e121d0df1237387e'
  })

  depends_on 'py3_pytz'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
