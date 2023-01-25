require 'package'

class Py3_sphinxcontrib_applehelp < Package
  description 'sphinxcontrib-applehelp is a sphinx extension which outputs Apple help books.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '1.0.2'
  version "#{@_ver}-py3.11"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-applehelp.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_applehelp/1.0.2-py3.11_armv7l/py3_sphinxcontrib_applehelp-1.0.2-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_applehelp/1.0.2-py3.11_armv7l/py3_sphinxcontrib_applehelp-1.0.2-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_applehelp/1.0.2-py3.11_i686/py3_sphinxcontrib_applehelp-1.0.2-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_applehelp/1.0.2-py3.11_x86_64/py3_sphinxcontrib_applehelp-1.0.2-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '05e3b5cabd4715eca60124b4a5fd135a408be2455cddc7a98fd4bed21522704c',
     armv7l: '05e3b5cabd4715eca60124b4a5fd135a408be2455cddc7a98fd4bed21522704c',
       i686: 'a76eb2c1d97dc6755d4e30a66906d5f27c5f3ea72f5f466a4229b9282fd8ed98',
     x86_64: '972c91c7b6844715480cd97b415da0a8d794af96006c6e742dc92d515b7e2178'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
