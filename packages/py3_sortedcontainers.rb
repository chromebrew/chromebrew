require 'package'

class Py3_sortedcontainers < Package
  description 'Python Sorted Container Types: Sorted List, Sorted Dict, and Sorted Set'
  homepage 'http://www.grantjenks.com/docs/sortedcontainers/'
  @_ver = '2.4.0'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/grantjenks/python-sortedcontainers.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sortedcontainers/2.4.0_armv7l/py3_sortedcontainers-2.4.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sortedcontainers/2.4.0_armv7l/py3_sortedcontainers-2.4.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sortedcontainers/2.4.0_i686/py3_sortedcontainers-2.4.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sortedcontainers/2.4.0_x86_64/py3_sortedcontainers-2.4.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5df27f5b767c689603b55a89b4cfcedcb0af84bc7b4ffa0b115ea5c2f9dd1d12',
     armv7l: '5df27f5b767c689603b55a89b4cfcedcb0af84bc7b4ffa0b115ea5c2f9dd1d12',
       i686: '15cd15e5c6beeb420c6b7d31547494edb578ebc6f73121ac7ad5e98302c444e3',
     x86_64: 'f5703a9027306c694ed242d866fa2e90e6daf92b640fe76da27a027d070fbfef'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
