require 'package'

class Py3_pycryptodome < Package
  description 'Pycryptodome is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  @_ver = '3.11.0'
  version @_ver
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'https://github.com/Legrandin/pycryptodome.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodome/3.11.0_armv7l/py3_pycryptodome-3.11.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodome/3.11.0_armv7l/py3_pycryptodome-3.11.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodome/3.11.0_i686/py3_pycryptodome-3.11.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodome/3.11.0_x86_64/py3_pycryptodome-3.11.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '223c87b03a0786401de352def04643f6c5877802403096e56d66c8485733c320',
     armv7l: '223c87b03a0786401de352def04643f6c5877802403096e56d66c8485733c320',
       i686: '2986352e310c17fb04d1aa2339d6858a9c20891285e66ddfaa4bd5bc31a0139e',
     x86_64: '5487fc4119e0d8e0efe75e3b3d143647a5f1927afe83fb7d85cf32dd0bdec5c0'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
