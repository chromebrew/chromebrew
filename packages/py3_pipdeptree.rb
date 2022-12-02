require 'package'

class Py3_pipdeptree < Package
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  @_ver = '2.2.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/naiquevin/pipdeptree.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pipdeptree/2.2.0-py3.11_armv7l/py3_pipdeptree-2.2.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pipdeptree/2.2.0-py3.11_armv7l/py3_pipdeptree-2.2.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pipdeptree/2.2.0-py3.11_i686/py3_pipdeptree-2.2.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pipdeptree/2.2.0-py3.11_x86_64/py3_pipdeptree-2.2.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'def0045207880e58c9103fe7cf9d4427f45e474f56ba283668795dc8f67e46b9',
     armv7l: 'def0045207880e58c9103fe7cf9d4427f45e474f56ba283668795dc8f67e46b9',
       i686: 'debbcdd861ada8ac88eecb15d4fd98a412f1876fce25dfab02371d985084f7e9',
     x86_64: '1dee5c0ebb751d44751107867841b39a8c1208826c2c88b5cc1aff56eb0eb018'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
