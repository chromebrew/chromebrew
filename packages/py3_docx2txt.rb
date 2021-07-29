require 'package'

class Py3_docx2txt < Package
  description 'Docx2txt is a pure python based utility to extract text and images from docx files.'
  homepage 'https://github.com/ankushshah89/python-docx2txt/'
  @_ver = '0.8'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ankushshah89/python-docx2txt.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docx2txt/0.8_armv7l/py3_docx2txt-0.8-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docx2txt/0.8_armv7l/py3_docx2txt-0.8-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docx2txt/0.8_x86_64/py3_docx2txt-0.8-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8c73dcb3572f19da071bddaf2340ea7c5415790dd87ccd94a2667d3528247ce0',
     armv7l: '8c73dcb3572f19da071bddaf2340ea7c5415790dd87ccd94a2667d3528247ce0',
     x86_64: 'e4bb30becfb81c7f3b0570ec3f4849f2e44e9cdc164cf7ded0af8c40b46c6a92'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
