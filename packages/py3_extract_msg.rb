require 'buildsystems/pip'

class Py3_extract_msg < Pip
  description 'Extract-msg extracts emails and attachments saved in Microsoft Outlook\'s .msg files.'
  homepage 'https://github.com/mattgwwalker/msg-extractor/'
  version "0.58.2-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0a378b5e7f64688eb23a03fef8913320f92e32bc9aec68e1337cfbabd8d9e3cf',
     armv7l: '0a378b5e7f64688eb23a03fef8913320f92e32bc9aec68e1337cfbabd8d9e3cf',
       i686: '0d39fcf0c7402b380b1bee818120e08019ca3ae8ccbd09af958c39ac245c065d',
     x86_64: '16aeed6b4c653cdf51e007ca70dc7c77abd560e6d3e480ce42143399c3779099'
  })

  depends_on 'py3_imapclient'
  depends_on 'py3_olefile'
  depends_on 'py3_tzlocal'
  depends_on 'python3' => :logical

  no_source_build
end
