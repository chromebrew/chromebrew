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
    aarch64: 'b4cb569642d6d9e4f66e2d14e7132bfb55599d699b5d0d727fbef6021cf29391',
     armv7l: 'b4cb569642d6d9e4f66e2d14e7132bfb55599d699b5d0d727fbef6021cf29391',
       i686: 'c3a0b5839e184a6c5e19aa0ba41654f1a4853d7c0c50f7ca449a13054d86bc2f',
     x86_64: 'f1129b5c03cf9ba43290e0db5a1c52ef37c006b0fc7aa52a677c5832959ad442'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
