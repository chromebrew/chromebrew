require 'package'

class Py3_pyasn1 < Package
  description 'PyASN.1 is a generic ASN.1 library for Python'
  homepage 'https://github.com/etingof/pyasn1/'
  @_ver = '0.4.8'
  version "#{@_ver}-1"
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/etingof/pyasn1.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyasn1/0.4.8-1_armv7l/py3_pyasn1-0.4.8-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyasn1/0.4.8-1_armv7l/py3_pyasn1-0.4.8-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyasn1/0.4.8-1_i686/py3_pyasn1-0.4.8-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyasn1/0.4.8-1_x86_64/py3_pyasn1-0.4.8-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'dd0565b0c1d682b4d65d308a64220937ef1aa0e31581e245c6dd4eddbca06b59',
     armv7l: 'dd0565b0c1d682b4d65d308a64220937ef1aa0e31581e245c6dd4eddbca06b59',
       i686: '56ff493b79f36b107914e2d97a81e7a4307e07f2b993aa42a8e2e8de7de99572',
     x86_64: '27cf2e8a6867c96e506c75acce88bb05fb628b3cabade79c67f0e38beeb46247'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
