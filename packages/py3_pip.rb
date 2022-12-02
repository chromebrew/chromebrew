require 'package'

class Py3_pip < Package
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  @_ver = '22.3.1'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/22.3.1-py3.11_armv7l/py3_pip-22.3.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/22.3.1-py3.11_armv7l/py3_pip-22.3.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/22.3.1-py3.11_i686/py3_pip-22.3.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/22.3.1-py3.11_x86_64/py3_pip-22.3.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fef14295481a2740d07e716905748df9cae0d5b1bc686ddb7bdc683bd4835284',
     armv7l: 'fef14295481a2740d07e716905748df9cae0d5b1bc686ddb7bdc683bd4835284',
       i686: 'af84a40117c7257a907c3c44955cb56ab41240a4f45ec69622c1f115fc69bec0',
     x86_64: 'da150010a81c82c2f69aa60136bdbb1b44a3c8574f8bbe9543de72edf917794b'
  })

  depends_on 'python3'
  depends_on 'py3_setuptools'
  depends_on 'py3_wheel'

  conflicts_ok

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"

    # Make pip3 the default pip
    # FileUtils.ln_s "pip3", "#{CREW_DEST_PREFIX}/bin/pip" # This automatically happens
  end
end
