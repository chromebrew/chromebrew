require 'package'

class Py3_olefile < Package
  description 'Olefile is a Python package to parse, read and write Microsoft OLE2 files.'
  homepage 'https://www.decalage.info/python/olefileio/'
  @_ver = '0.46'
  version "#{@_ver}-1"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/decalage2/olefile.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_olefile/0.46-1_armv7l/py3_olefile-0.46-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_olefile/0.46-1_armv7l/py3_olefile-0.46-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_olefile/0.46-1_i686/py3_olefile-0.46-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_olefile/0.46-1_x86_64/py3_olefile-0.46-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '3a8b94a0bfd5b2c986bddd97a075531620c5bb397ffd10e1a90d20ca563447f0',
     armv7l: '3a8b94a0bfd5b2c986bddd97a075531620c5bb397ffd10e1a90d20ca563447f0',
       i686: '5fe2ad2a5a2968a921e1361ebd4d1350170d1152048e9ab2828bf2d65d89b590',
     x86_64: '4ceb7c1be7292430825a25b026215fe7e26ab82c339885269a7dd8bf5e47a678'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
