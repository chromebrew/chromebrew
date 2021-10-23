require 'package'

class Py3_pptx < Package
  description 'Python PPTX generates and manipulates Open XML PowerPoint files.'
  homepage 'https://github.com/scanny/python-pptx/'
  @_ver = '0.6.21'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/scanny/python-pptx.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pptx/0.6.21_armv7l/py3_pptx-0.6.21-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pptx/0.6.21_armv7l/py3_pptx-0.6.21-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pptx/0.6.21_i686/py3_pptx-0.6.21-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pptx/0.6.21_x86_64/py3_pptx-0.6.21-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '36f03d7b1422a1ec9b5e25b89b004dd252b6db48957a6abb4523548521c00c43',
     armv7l: '36f03d7b1422a1ec9b5e25b89b004dd252b6db48957a6abb4523548521c00c43',
       i686: '5efb615fa9153f959ed870593c2e608e0783fdf27447c7e63f04ec0dad4c5836',
     x86_64: '03a5fc0b46cb9f3de13aa0822eaf27b69901d0ce6c496eabcbd1b19b17836e11'
  })

  depends_on 'py3_lxml'
  depends_on 'py3_pillow'
  depends_on 'py3_xlsxwriter'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
