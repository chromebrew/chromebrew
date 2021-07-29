require 'package'

class Py3_olefile < Package
  description 'Olefile is a Python package to parse, read and write Microsoft OLE2 files.'
  homepage 'https://www.decalage.info/python/olefileio/'
  @_ver = '0.46'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/decalage2/olefile.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_olefile/0.46_armv7l/py3_olefile-0.46-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_olefile/0.46_armv7l/py3_olefile-0.46-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_olefile/0.46_x86_64/py3_olefile-0.46-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '82216940336248467735a00ed9178a7dda6da52458ceff0ee29e41705ff443a5',
     armv7l: '82216940336248467735a00ed9178a7dda6da52458ceff0ee29e41705ff443a5',
     x86_64: '9869cf81203d8a9ae564569e9977bdfd64890c6ba1dd7128593421f42028e600'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
