require 'package'

class Py3_future < Package
  description 'Future provides clean single-source support for Python 3 and 2.'
  homepage 'https://python-future.org/'
  @_ver = '0.18.2'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/PythonCharmers/python-future.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_future/0.18.2-1_armv7l/py3_future-0.18.2-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_future/0.18.2-1_armv7l/py3_future-0.18.2-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_future/0.18.2-1_i686/py3_future-0.18.2-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_future/0.18.2-1_x86_64/py3_future-0.18.2-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '4ad7452419735a7a1b8c8d1465221733dd403216f28f1552d7100156b1025f8e',
     armv7l: '4ad7452419735a7a1b8c8d1465221733dd403216f28f1552d7100156b1025f8e',
       i686: '12f279bf4d49d62908307b61a190d8be5e60dd1640799a09f7e1bc6777307afa',
     x86_64: '79cddc48c0ea4bd4c4d3c31da7dc181cd47478960fac3fbf80884946179d66ba'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
