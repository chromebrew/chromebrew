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
    aarch64: 'b2ad566f0864f8dac9df6f616b906e4130c6f3158a765b7f121b8e129a6810e0',
     armv7l: 'b2ad566f0864f8dac9df6f616b906e4130c6f3158a765b7f121b8e129a6810e0',
       i686: '628fd911acc18356127c8437cfee8ffd9424c3487db068a948063c1422389ac1',
     x86_64: '756d3eb7bce044c5997b65bb7475118a0370b6fcbd2e6750c028dfc153ad3114'
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
