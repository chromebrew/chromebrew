require 'package'

class Py3_agate < Package
  description 'Agate is a data analysis library that is optimized for humans instead of machines.'
  homepage 'https://agate.readthedocs.io/'
  @_ver = '1.6.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/agate.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate/1.6.1_armv7l/py3_agate-1.6.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate/1.6.1_armv7l/py3_agate-1.6.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate/1.6.1_x86_64/py3_agate-1.6.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'bcc3db13c5aa17e5e8234869b977011960b5cd4f488d92c3cb52adf4fbf3ac55',
     armv7l: 'bcc3db13c5aa17e5e8234869b977011960b5cd4f488d92c3cb52adf4fbf3ac55',
     x86_64: '9c7fefd9fe2e3d2a5f961efe28ad90758882e76f0e5101f07811194291883f77'
  })

  depends_on 'py3_babel'
  depends_on 'py3_six'
  depends_on 'py3_pyicu'
  depends_on 'py3_pytimeparse'
  depends_on 'py3_slugify'
  depends_on 'py3_isodate'
  depends_on 'py3_leather'
  depends_on 'py3_parsedatetime'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
