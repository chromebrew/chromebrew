require 'package'

class Py3_mock < Package
  description 'Mock is a testing library in Python.'
  homepage 'https://mock.readthedocs.org/'
  @_ver = '4.0.3'
  version @_ver
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/testing-cabal/mock.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mock/4.0.3_armv7l/py3_mock-4.0.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mock/4.0.3_armv7l/py3_mock-4.0.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mock/4.0.3_i686/py3_mock-4.0.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mock/4.0.3_x86_64/py3_mock-4.0.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8811dd4d68642ea79a00943b6013ba3d9f6e0e12b8c485a1b871010c9b8cf943',
     armv7l: '8811dd4d68642ea79a00943b6013ba3d9f6e0e12b8c485a1b871010c9b8cf943',
       i686: '8892d22ca4d6b6968b78e13f36f734a07ced9bd9062b79fcbeec945d12760af6',
     x86_64: '2ff3e0801c0e2d8df05fa4e614a41641f4551aaeb158ab90780fe2c6c793b78e'
  })

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
