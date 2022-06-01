require 'package'

class Py3_dbfread < Package
  description 'DBFread reads DBF Files with Python.'
  homepage 'https://dbfread.readthedocs.io/'
  @_ver = '2.0.7'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/olemb/dbfread.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbfread/2.0.7-1_armv7l/py3_dbfread-2.0.7-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbfread/2.0.7-1_armv7l/py3_dbfread-2.0.7-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbfread/2.0.7-1_i686/py3_dbfread-2.0.7-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbfread/2.0.7-1_x86_64/py3_dbfread-2.0.7-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5e26415d709930abf7483e9d218028a3b23a83da706c982a9ec359f24d6a237d',
     armv7l: '5e26415d709930abf7483e9d218028a3b23a83da706c982a9ec359f24d6a237d',
       i686: '9fca2e015bbb73af1128dcd28813181f6ab89820dc42e5e34d051c807bf729b6',
     x86_64: 'b039bc216450fb4b2ae00ef2dfb01b5c01c22acc85f06708ebd4a53263eb6b67'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
