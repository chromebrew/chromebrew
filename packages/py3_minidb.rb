require 'package'

class Py3_minidb < Package
  description 'Minidb is a simple SQLite3-based store for Python objects.'
  homepage 'http://thp.io/2010/minidb/'
  @_ver = '2.0.5'
  version @_ver
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/thp/minidb.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_minidb/2.0.5_armv7l/py3_minidb-2.0.5-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_minidb/2.0.5_armv7l/py3_minidb-2.0.5-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_minidb/2.0.5_i686/py3_minidb-2.0.5-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_minidb/2.0.5_x86_64/py3_minidb-2.0.5-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '4955f99cd35501ffeb4a62dc36b61d589affae9ae868bf8ac49844686620579d',
     armv7l: '4955f99cd35501ffeb4a62dc36b61d589affae9ae868bf8ac49844686620579d',
       i686: 'a01d64e5613ca1bc01d6812398115067aaf8561056c36e9194208bcd8539b44d',
     x86_64: '2c3e402fb251f9c08b0d8c0cf598be5af5346f50b56243d52beb002aa7409e17'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
