require 'package'

class Py3_pipdeptree < Package
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  @_ver = '2.2.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/naiquevin/pipdeptree.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pipdeptree/2.2.0_armv7l/py3_pipdeptree-2.2.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pipdeptree/2.2.0_armv7l/py3_pipdeptree-2.2.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pipdeptree/2.2.0_i686/py3_pipdeptree-2.2.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pipdeptree/2.2.0_x86_64/py3_pipdeptree-2.2.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '43bcc3d8c7cafc9ff0ffb11c3ac02d711bad8c3a255544ae1359f6266b61c96b',
     armv7l: '43bcc3d8c7cafc9ff0ffb11c3ac02d711bad8c3a255544ae1359f6266b61c96b',
       i686: 'def4e8eddadd8d3e5842c7c55796c753bd56fc7e4dd07b825e05703a73647906',
     x86_64: 'a33079dea17ba00a73708eece8b455506abe1a3d46ed814f68176d2b62f7c9d0'
  })

  depends_on 'py3_pip'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
