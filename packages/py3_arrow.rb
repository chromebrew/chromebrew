require 'package'

class Py3_arrow < Package
  description 'Arrow is a Python library that offers a sensible and human-friendly approach to creating, manipulating, formatting and converting dates, times and timestamps.'
  homepage 'https://arrow.readthedocs.io/'
  @_ver = '1.1.1'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/arrow-py/arrow.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_arrow/1.1.1_armv7l/py3_arrow-1.1.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_arrow/1.1.1_armv7l/py3_arrow-1.1.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_arrow/1.1.1_i686/py3_arrow-1.1.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_arrow/1.1.1_x86_64/py3_arrow-1.1.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '983dbf6125d0198abfc2abb9ca9c9ee98e15ea07ef407a16e8900ea58821e881',
     armv7l: '983dbf6125d0198abfc2abb9ca9c9ee98e15ea07ef407a16e8900ea58821e881',
       i686: '7d2f1c0d8505bc86f4612fdd6761cee8dcc416517acce1f7058f4d32d4d0f317',
     x86_64: 'b9000ab8724f764010ebfe5a1d7ab4a144c7921c1ca29ca08c69fbe460c455b1'
  })

  depends_on 'py3_dateutil'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
