require 'package'

class Py3_idna < Package
  description 'IDNA provides internationalized domain names for Python.'
  homepage 'https://github.com/kjd/idna/'
  @_ver = '3.3'
  version "#{@_ver}-py3.11"
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/kjd/idna.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_idna/3.3-py3.11_armv7l/py3_idna-3.3-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_idna/3.3-py3.11_armv7l/py3_idna-3.3-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_idna/3.3-py3.11_i686/py3_idna-3.3-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_idna/3.3-py3.11_x86_64/py3_idna-3.3-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9f4e061e59ff216ea7c6327f427d510732937b4b3a0bc311e53d7e4e5e697966',
     armv7l: '9f4e061e59ff216ea7c6327f427d510732937b4b3a0bc311e53d7e4e5e697966',
       i686: '84eeeab44698ccb37c798d7b716574359db6ea09a0c8870b14740e7115d962fa',
     x86_64: '0be1c3bce7ae0355b442ffd7d47f662be9ee08a3629213b8d75d78dc76ac1be0'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
