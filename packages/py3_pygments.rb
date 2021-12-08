require 'package'

class Py3_pygments < Package
  description 'Python Syntax Highlighter'
  homepage 'https://pygments.org/'
  @_ver = '2.10.0'
  version @_ver
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/pygments/pygments.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pygments/2.10.0_armv7l/py3_pygments-2.10.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pygments/2.10.0_armv7l/py3_pygments-2.10.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pygments/2.10.0_i686/py3_pygments-2.10.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pygments/2.10.0_x86_64/py3_pygments-2.10.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '05f8e57151eb22a64f67e8fa00ac1b76d0efa9e43079edf54de41620ca873763',
     armv7l: '05f8e57151eb22a64f67e8fa00ac1b76d0efa9e43079edf54de41620ca873763',
       i686: '8ff445eefbefe12ace34b88f87323f5bf51e544493122ecece144e790d84beb8',
     x86_64: '81263942fb77e44d47ea1dd932d2615b5188773a24609612f5d6d2a981f4aa52'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
