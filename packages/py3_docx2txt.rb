require 'package'

class Py3_docx2txt < Package
  description 'Docx2txt is a pure python based utility to extract text and images from docx files.'
  homepage 'https://github.com/ankushshah89/python-docx2txt/'
  @_ver = '0.8'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ankushshah89/python-docx2txt.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docx2txt/0.8-1_armv7l/py3_docx2txt-0.8-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docx2txt/0.8-1_armv7l/py3_docx2txt-0.8-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docx2txt/0.8-1_i686/py3_docx2txt-0.8-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_docx2txt/0.8-1_x86_64/py3_docx2txt-0.8-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '4fe7c0c804b47548bcab290e3a10d210a58571300819faa56c7e2fca566322ed',
     armv7l: '4fe7c0c804b47548bcab290e3a10d210a58571300819faa56c7e2fca566322ed',
       i686: 'b0c2208085a069a88bcc16794e1d7853fd4ff8ac478b1df8021639e213e3a764',
     x86_64: 'dc9e85b1e826f850f4dc63f46c58246a30aeb834490d7961d5c46c404f71b808'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
