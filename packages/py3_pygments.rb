require 'package'

class Py3_pygments < Package
  description 'Python Syntax Highlighter'
  homepage 'https://pygments.org/'
  @_ver = '2.8.1'
  version @_ver
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/pygments/pygments.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pygments/2.8.1_armv7l/py3_pygments-2.8.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pygments/2.8.1_armv7l/py3_pygments-2.8.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pygments/2.8.1_i686/py3_pygments-2.8.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pygments/2.8.1_x86_64/py3_pygments-2.8.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '86d7cc5515cdcedfe1b73dcb2ad3e89cb7e2b431c81f348bd7fc047b6698c734',
     armv7l: '86d7cc5515cdcedfe1b73dcb2ad3e89cb7e2b431c81f348bd7fc047b6698c734',
       i686: 'e4fd62a071d8eeab567fa26be829ce209401fbec385696c56a4f80978c9e5491',
     x86_64: '33548074ae94058a84fe3489913b235ddf3c0578d30f825d2bcffbc8caccfd04'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
