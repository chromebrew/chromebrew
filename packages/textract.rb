require 'package'

class Textract < Package
  description 'Textract provides text extracting tools for many formats.'
  homepage 'http://textract.readthedocs.io/'
  version '1.6.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/deanmalmgren/textract.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/textract/1.6.4_armv7l/textract-1.6.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/textract/1.6.4_armv7l/textract-1.6.4-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/textract/1.6.4_i686/textract-1.6.4-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/textract/1.6.4_x86_64/textract-1.6.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd621a56b5d12557eb7d96c234a70f46fe009bb9f9cf4cb3ccf1d3d2193f95ce2',
     armv7l: 'd621a56b5d12557eb7d96c234a70f46fe009bb9f9cf4cb3ccf1d3d2193f95ce2',
       i686: '959cde346d151c1bf951a7fa41c687c576ef0dc967e4c413f72e60bf06d9c31c',
     x86_64: '0b3fedcbfd45de8555ac00ae5bf343bc979a0d8b843315335959996332e8fb90'
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
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
