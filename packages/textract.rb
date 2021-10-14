require 'package'

class Textract < Package
  description 'Textract provides text extracting tools for many formats.'
  homepage 'http://textract.readthedocs.io/'
  @_ver = '1.6.4'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/deanmalmgren/textract.git'
  git_hashtag "v#{@_ver}"

  depends_on 'py3_pdfminer_six'
  depends_on 'py3_ebooklib'
  depends_on 'py3_pptx'
  depends_on 'py3_extract_msg'
  depends_on 'py3_xlrd'
  depends_on 'py3_docx2txt'
  depends_on 'py3_argcomplete'
  depends_on 'py3_speechrecognition'
  depends_on 'py3_chardet'
  depends_on 'py3_beautifulsoup4'
  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
