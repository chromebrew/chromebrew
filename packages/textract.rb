require 'buildsystems/pip'

class Textract < Pip
  description 'Textract provides text extracting tools for many formats.'
  homepage 'http://textract.readthedocs.io/'
  version '2.0.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ff36c30fa82026d3c7753cdbd7ab2230a64c77fe6e40e185ed7e1ffb43aa0411',
     armv7l: 'ff36c30fa82026d3c7753cdbd7ab2230a64c77fe6e40e185ed7e1ffb43aa0411',
     x86_64: 'b0a12650fd86780c09af6908c3c1fb780fe67e9e4c73e6e38522af1dda7b18fa'
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
