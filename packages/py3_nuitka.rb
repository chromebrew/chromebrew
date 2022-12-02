require 'package'

class Py3_nuitka < Package
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  @_ver = '0.6.18.5'
  version "#{@_ver}-py3.11"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/78/b3/e8b6f9d728454a1be16bcc4921e5ea55804587d89e8f8637c89d33ae11da/Nuitka-0.6.18.5.tar.gz'
  source_sha256 'a9c7b49d0bd6ae73fe299772b0f2ae95e6d5d9a20de128932bcc5b92826f0ea7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_nuitka/0.6.18.5-py3.11_armv7l/py3_nuitka-0.6.18.5-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_nuitka/0.6.18.5-py3.11_armv7l/py3_nuitka-0.6.18.5-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_nuitka/0.6.18.5-py3.11_i686/py3_nuitka-0.6.18.5-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_nuitka/0.6.18.5-py3.11_x86_64/py3_nuitka-0.6.18.5-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4fcf6514fe689aaa2ecbd66d027a58a6a11e728c3dec0f2192c7c1a1a73ae949',
     armv7l: '4fcf6514fe689aaa2ecbd66d027a58a6a11e728c3dec0f2192c7c1a1a73ae949',
       i686: '673287697f6770a84bdfb776a4701e423532638931d981c479a1ef48ad7ad148',
     x86_64: '4f663d79719d33ac6142331106dc0db871d040bc0f6c4c5610fd4ff0787f01aa'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
