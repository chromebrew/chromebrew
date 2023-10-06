require 'buildsystems/pip'

class Py3_extract_msg < Pip
  description 'Extract-msg extracts emails and attachments saved in Microsoft Outlook\'s .msg files.'
  homepage 'https://github.com/mattgwwalker/msg-extractor/'
  @_ver = '0.28.7'
  version "#{@_ver}-py3.12"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_tzlocal'
  depends_on 'py3_olefile'
  depends_on 'py3_imapclient'
  depends_on 'python3' => :build
  no_compile_needed
end
