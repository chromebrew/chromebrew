require 'package'

class Textract < Package
  description 'Textract provides text extracting tools for many formats.'
  homepage 'http://textract.readthedocs.io/'
  @_ver = '1.6.3'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/deanmalmgren/textract.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/textract/1.6.3_armv7l/textract-1.6.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/textract/1.6.3_armv7l/textract-1.6.3-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/textract/1.6.3_x86_64/textract-1.6.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '2acbe613d6da563b6d2448901a0aeae370e098cae979329d347cf2fc83b03d15',
     armv7l: '2acbe613d6da563b6d2448901a0aeae370e098cae979329d347cf2fc83b03d15',
     x86_64: '14e5dc95823db12a0f4cb9f355db91066f6a4314049a78d3fc82fa671aeb8f69'
  })

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
