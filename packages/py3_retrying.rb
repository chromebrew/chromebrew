require 'package'

class Py3_retrying < Package
  description 'Retrying simplifies the task of adding retry behavior to just about anything.'
  homepage 'https://github.com/rholder/retrying/'
  @_ver = '1.3.3'
  version "#{@_ver}-py3.11"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/rholder/retrying.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_retrying/1.3.3-py3.11_armv7l/py3_retrying-1.3.3-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_retrying/1.3.3-py3.11_armv7l/py3_retrying-1.3.3-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_retrying/1.3.3-py3.11_i686/py3_retrying-1.3.3-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_retrying/1.3.3-py3.11_x86_64/py3_retrying-1.3.3-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6ed0f138dd05d302519be15ac530c0961bc784a767850b6eada9ce83baa4e5b6',
     armv7l: '6ed0f138dd05d302519be15ac530c0961bc784a767850b6eada9ce83baa4e5b6',
       i686: 'b1a03f12b0b0482da8c4275b5852945f98a0681635c382a8443d109de3652e9b',
     x86_64: '5cbf53730781ec5b61eecedc78b5900cc7d505dc8835b35c549361fb8ee8f6b8'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
