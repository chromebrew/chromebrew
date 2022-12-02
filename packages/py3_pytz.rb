require 'package'

class Py3_pytz < Package
  description 'pytz brings the Olson tz database into Python.'
  homepage 'https://pythonhosted.org/pytz/'
  @_ver = '2021.3'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/e3/8e/1cde9d002f48a940b9d9d38820aaf444b229450c0854bdf15305ce4a3d1a/pytz-2021.3.tar.gz'
  source_sha256 'acad2d8b20a1af07d4e4c9d2e9285c5ed9104354062f275f3fcd88dcef4f1326'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytz/2021.3-py3.11_armv7l/py3_pytz-2021.3-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytz/2021.3-py3.11_armv7l/py3_pytz-2021.3-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytz/2021.3-py3.11_i686/py3_pytz-2021.3-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytz/2021.3-py3.11_x86_64/py3_pytz-2021.3-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '17f1e90d1c7af248b5bce82030551e245ed7d467d8f1a145549708b6c2022225',
     armv7l: '17f1e90d1c7af248b5bce82030551e245ed7d467d8f1a145549708b6c2022225',
       i686: 'aff25a04682350a37c6074a875a8e049f39dbbb9c87978bc0920a2e26138ead4',
     x86_64: '07ca710fd0b7f336691b89343e65b820424f2e9d457b4d975deb49d5f7113052'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
