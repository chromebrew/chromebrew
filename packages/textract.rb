require 'buildsystems/pip'

class Textract < Pip
  description 'Textract provides text extracting tools for many formats.'
  homepage 'http://textract.readthedocs.io/'
  version '2.1.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '691ad0ecb93a19cd2657c7ee43f01171a3c2bf11cd385d1eaba36b6b7a9108f1',
     armv7l: '691ad0ecb93a19cd2657c7ee43f01171a3c2bf11cd385d1eaba36b6b7a9108f1',
     x86_64: 'c9660d99772e5146aa8ad09ec190cca6cd0842611ca3090f942a536eb71e5db1'
  })

  depends_on 'py3_argcomplete' => :library
  depends_on 'py3_beautifulsoup4' => :library
  depends_on 'py3_chardet' => :library
  depends_on 'py3_docx2txt' => :library
  depends_on 'py3_ebooklib' => :library
  depends_on 'py3_extract_msg' => :library
  depends_on 'py3_pdfminer_six' => :library
  depends_on 'py3_python_pptx' => :library
  depends_on 'py3_six' => :library
  depends_on 'py3_speechrecognition' => :library
  depends_on 'py3_xlrd' => :library
  depends_on 'python3' => :logical

  no_source_build
end
