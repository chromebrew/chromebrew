require 'package'

class Py3_agate < Package
  description 'Agate is a data analysis library that is optimized for humans instead of machines.'
  homepage 'https://agate.readthedocs.io/'
  @_ver = '1.6.3'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/agate.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate/1.6.3_armv7l/py3_agate-1.6.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate/1.6.3_armv7l/py3_agate-1.6.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate/1.6.3_i686/py3_agate-1.6.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate/1.6.3_x86_64/py3_agate-1.6.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '357edbdec5c4cf615877846eb1cf7abe0d6ffa5897c5a5b74268d1590df4bde8',
     armv7l: '357edbdec5c4cf615877846eb1cf7abe0d6ffa5897c5a5b74268d1590df4bde8',
       i686: 'a46ea8c01fd442aebfe7f2e7dc26b79edc6419dc83909c2a66b5a16333427084',
     x86_64: '0015ba29995578c47bd9f36abeebdfb400e00b9b137fdeed9ced4d6d151f41bc'
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
