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
    aarch64: '65c36a311c61ec0feb56529cc4e74f69c8b7863eff1dbda03652babeb13b96e9',
     armv7l: '65c36a311c61ec0feb56529cc4e74f69c8b7863eff1dbda03652babeb13b96e9',
       i686: 'b81af5016150e7faa5909e6e752b893d69afd67ede4810749d96d9bf021b70a1',
     x86_64: '1fc91c764e07cdb7e503b365895edcc0e36ddb3383540e227de332f84ed8e5b5'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
