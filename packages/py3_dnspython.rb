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
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dnspython/2.1.0_i686/py3_dnspython-2.1.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dnspython/2.1.0_x86_64/py3_dnspython-2.1.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '50a4b67371fd081c04d6a49b94becb3c24a44b9467f1fa8dc5de4f1ae3526224',
     armv7l: '50a4b67371fd081c04d6a49b94becb3c24a44b9467f1fa8dc5de4f1ae3526224',
       i686: '8fe0cb5ebf032b2557bb4398d8d940353c2affc05bc1bdfabaf24cfeb4dcec11',
     x86_64: '64ff23cfa6c0e3172b90f4e589a78964b7a2de8fd419098bd7e6ea97ca713a5b'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
