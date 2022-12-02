require 'package'

class Py3_pygments < Package
  description 'Python Syntax Highlighter'
  homepage 'https://pygments.org/'
  @_ver = '2.10.0'
  version "#{@_ver}-py3.11"
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/pygments/pygments.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pygments/2.10.0-py3.11_armv7l/py3_pygments-2.10.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pygments/2.10.0-py3.11_armv7l/py3_pygments-2.10.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pygments/2.10.0-py3.11_i686/py3_pygments-2.10.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pygments/2.10.0-py3.11_x86_64/py3_pygments-2.10.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b642cf8b540ee42f7852df37b690cbf712be2dddf4f5327ddf78448fd3198fa8',
     armv7l: 'b642cf8b540ee42f7852df37b690cbf712be2dddf4f5327ddf78448fd3198fa8',
       i686: 'a0abc82820334c1c07b3c8d8177d121436efcc89e5074542c8252f173a2652ac',
     x86_64: 'bf15045e59e9b4e11f4ad81a57f50ddbbe34bcd4b7cb76ef219aa954de4809b2'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
