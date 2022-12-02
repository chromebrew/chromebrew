require 'package'

class Py3_sphinxcontrib_devhelp < Package
  description 'Sphinxcontrib-devhelp is a sphinx extension which outputs a Devhelp document.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '1.0.2-883c'
  version "#{@_ver}-py3.11"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-devhelp.git'
  git_hashtag '883cdd991b38dec85edafdeb61cb6af4064ca8f6'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_devhelp/1.0.2-883c-py3.11_armv7l/py3_sphinxcontrib_devhelp-1.0.2-883c-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_devhelp/1.0.2-883c-py3.11_armv7l/py3_sphinxcontrib_devhelp-1.0.2-883c-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_devhelp/1.0.2-883c-py3.11_i686/py3_sphinxcontrib_devhelp-1.0.2-883c-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_devhelp/1.0.2-883c-py3.11_x86_64/py3_sphinxcontrib_devhelp-1.0.2-883c-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '154eb7b87e05b2fc220d9b258ca8f529b5a6b209bfbe75e09a473e81c3b63cfc',
     armv7l: '154eb7b87e05b2fc220d9b258ca8f529b5a6b209bfbe75e09a473e81c3b63cfc',
       i686: 'd7f10002e6790b7df40d000e53009d5c89e29dc28c54df36ad849420c2e5b8cc',
     x86_64: '6bd6e4dfb8897ba567d3682f6860b06422bc39a68bbb2afd16671f3a1a17b41e'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
