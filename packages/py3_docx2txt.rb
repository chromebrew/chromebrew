require 'package'

class Py3_docx2txt < Package
  description 'Docx2txt is a pure python based utility to extract text and images from docx files.'
  homepage 'https://github.com/ankushshah89/python-docx2txt/'
  @_ver = '0.8'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ankushshah89/python-docx2txt.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docx2txt/0.8-py3.11_armv7l/py3_docx2txt-0.8-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docx2txt/0.8-py3.11_armv7l/py3_docx2txt-0.8-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docx2txt/0.8-py3.11_i686/py3_docx2txt-0.8-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docx2txt/0.8-py3.11_x86_64/py3_docx2txt-0.8-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '204be52f2daaef90310b8c7b186509d433db74e4c1a30f0bbfdc06d04272cff2',
     armv7l: '204be52f2daaef90310b8c7b186509d433db74e4c1a30f0bbfdc06d04272cff2',
       i686: '26a0e64b86a9088bb81ed9e6730b37b0b0a9d3fe4960c87e5417a11c4e4630a3',
     x86_64: '1def4380df5dbdcb05f653dfa2f974d9356115f6949c8fde9ce1f06dd985a863'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
