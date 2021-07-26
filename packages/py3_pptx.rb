require 'package'

class Py3_pptx < Package
  description 'Python PPTX generates and manipulates Open XML PowerPoint files.'
  homepage 'https://github.com/scanny/python-pptx/'
  @_ver = '0.6.18'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/scanny/python-pptx.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pptx/0.6.18_armv7l/py3_pptx-0.6.18-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pptx/0.6.18_armv7l/py3_pptx-0.6.18-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pptx/0.6.18_x86_64/py3_pptx-0.6.18-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0d48691a41df2ff7af5c5568214b312350909554a95ef3e2661bc56dbb7ea9d1',
     armv7l: '0d48691a41df2ff7af5c5568214b312350909554a95ef3e2661bc56dbb7ea9d1',
     x86_64: 'cb94d5f39a4eef3f50b24bc089f5cb6a462a589c5dc7a778b82c18beaecd6d6b'
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
