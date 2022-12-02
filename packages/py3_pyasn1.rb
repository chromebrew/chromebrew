require 'package'

class Py3_pyasn1 < Package
  description 'PyASN.1 is a generic ASN.1 library for Python'
  homepage 'https://github.com/etingof/pyasn1/'
  @_ver = '0.4.8'
  version "#{@_ver}-py3.11"
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/etingof/pyasn1.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyasn1/0.4.8-py3.11_armv7l/py3_pyasn1-0.4.8-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyasn1/0.4.8-py3.11_armv7l/py3_pyasn1-0.4.8-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyasn1/0.4.8-py3.11_i686/py3_pyasn1-0.4.8-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyasn1/0.4.8-py3.11_x86_64/py3_pyasn1-0.4.8-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '78d77366c5fbfc2c48ef365fb8f9e298eef9e0600c84dc11d16f92e80e395e99',
     armv7l: '78d77366c5fbfc2c48ef365fb8f9e298eef9e0600c84dc11d16f92e80e395e99',
       i686: '97cdadd851d80ef77100a5639e11ebd4eebc3d849566f2e29f04fa660f284596',
     x86_64: '56e14fe97553facf807b9436278956681ce3a82cf357ae2631768f14a64db155'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
