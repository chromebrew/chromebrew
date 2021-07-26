require 'package'

class Py3_dnspython < Package
  description 'DNSPython is a DNS toolkit.'
  homepage 'https://www.dnspython.org/'
  @_ver = '2.1.0'
  version @_ver
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/rthalley/dnspython.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dnspython/2.1.0_armv7l/py3_dnspython-2.1.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dnspython/2.1.0_armv7l/py3_dnspython-2.1.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dnspython/2.1.0_x86_64/py3_dnspython-2.1.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f8b99763641f16ac27a7083e8cf1b2a541b9c3f552c216ceef0cba314637e889',
     armv7l: 'f8b99763641f16ac27a7083e8cf1b2a541b9c3f552c216ceef0cba314637e889',
     x86_64: '7dace66ee94e5ad3332ce8c24879df9958b9bd141a022580db5a31298cb2d843'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
