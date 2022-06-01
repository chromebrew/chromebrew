require 'package'

class Py3_pytz < Package
  description 'pytz brings the Olson tz database into Python.'
  homepage 'https://pythonhosted.org/pytz/'
  @_ver = '2021.3'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/e3/8e/1cde9d002f48a940b9d9d38820aaf444b229450c0854bdf15305ce4a3d1a/pytz-2021.3.tar.gz'
  source_sha256 'acad2d8b20a1af07d4e4c9d2e9285c5ed9104354062f275f3fcd88dcef4f1326'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytz/2021.3_armv7l/py3_pytz-2021.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytz/2021.3_armv7l/py3_pytz-2021.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytz/2021.3_i686/py3_pytz-2021.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytz/2021.3_x86_64/py3_pytz-2021.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '802a3c3e79d6e0694eeb7d39ade44f216a2c3189b5be46d060917d26f4ae6f49',
     armv7l: '802a3c3e79d6e0694eeb7d39ade44f216a2c3189b5be46d060917d26f4ae6f49',
       i686: '62e2cc62b0b94b75ab0ae6215f0dfe69ba384ffe56ed92822b7df45cd0cadd40',
     x86_64: '49fafd755f9968f1b370d39c89db0b37fede393aa7a1d00c9946e28411f9176b'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
