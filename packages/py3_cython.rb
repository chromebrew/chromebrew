require 'package'

class Py3_cython < Package
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  @_ver = '0.29.32'
  version "#{@_ver}-py3.11"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/cython/cython.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.32-py3.11_armv7l/py3_cython-0.29.32-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.32-py3.11_armv7l/py3_cython-0.29.32-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.32-py3.11_i686/py3_cython-0.29.32-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.32-py3.11_x86_64/py3_cython-0.29.32-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '81f5b9378f433b3439bd7787682c77375e58d1eaec78e314b81c1e14e92aa2db',
     armv7l: '81f5b9378f433b3439bd7787682c77375e58d1eaec78e314b81c1e14e92aa2db',
       i686: '2ca9fed51426f9ad7b73bc7c15b92186fbb249734a566091ec5eb5fc4538111a',
     x86_64: '9b89dc31b73ec39627bf6e9aab3a88c6416e3d6042224ae6599c731aa37a9513'
  })

  depends_on 'python3' => :build
  depends_on 'glibc' # R

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
