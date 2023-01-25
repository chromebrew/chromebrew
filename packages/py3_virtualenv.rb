require 'package'

class Py3_virtualenv < Package
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  @_ver = '20.8.1'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/virtualenv.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_virtualenv/20.8.1-py3.11_armv7l/py3_virtualenv-20.8.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_virtualenv/20.8.1-py3.11_armv7l/py3_virtualenv-20.8.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_virtualenv/20.8.1-py3.11_i686/py3_virtualenv-20.8.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_virtualenv/20.8.1-py3.11_x86_64/py3_virtualenv-20.8.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '37d8beb24bae83ef74e68760a911dfec3544a07e9243b0e126eaa81a0e161eed',
     armv7l: '37d8beb24bae83ef74e68760a911dfec3544a07e9243b0e126eaa81a0e161eed',
       i686: 'e30746ea692d8445b9f27be1664698287ca6dc26737cc9f5f6298981c4b61273',
     x86_64: '5ca1c04dceb46426022f4e74703e1429b2f2070562f451e5b04331617b9c6719'
  })

  depends_on 'py3_appdirs'
  depends_on 'py3_distlib'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
