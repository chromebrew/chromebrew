require 'package'

class Avocado_framework < Package
  description 'Avocado is a next generation testing framework inspired by Autotest and modern development tools such as git.'
  homepage 'https://avocado-framework.github.io/'
  @_ver = '91.0'
  version @_ver
  license 'GPL-2 and GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/avocado-framework/avocado.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/avocado_framework/91.0_armv7l/avocado_framework-91.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/avocado_framework/91.0_armv7l/avocado_framework-91.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/avocado_framework/91.0_i686/avocado_framework-91.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/avocado_framework/91.0_x86_64/avocado_framework-91.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '09256b27b731902f7f7caf43eafcbaa2fd0d0a8ca966bb0a7df1627f074bb8ca',
     armv7l: '09256b27b731902f7f7caf43eafcbaa2fd0d0a8ca966bb0a7df1627f074bb8ca',
       i686: '5a392ca22fc41847de0a86b5519c29942c1a481f4573044457739933bbdc5ff6',
     x86_64: '2b2aeb3906b2e2f707ea1b696f433294984daf0b03bcabd5b1b9fd81dfe625c1'
  })

  depends_on 'xdg_base'
  depends_on 'xzutils'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
