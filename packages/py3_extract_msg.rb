require 'buildsystems/pip'

class Py3_extract_msg < Pip
  description 'Extract-msg extracts emails and attachments saved in Microsoft Outlook\'s .msg files.'
  homepage 'https://github.com/mattgwwalker/msg-extractor/'
  version '0.49.0-py3.12'
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eddf34da96c5e1b819b9777d7a53359080280f20e15522402ce32ec943a79223',
     armv7l: 'eddf34da96c5e1b819b9777d7a53359080280f20e15522402ce32ec943a79223',
       i686: '7bedeb63ca20059ddfea517cae32d0b1dff8c2fa52f127d584a3e07ccb953131',
     x86_64: '403be74a87f5745e9e3f9f4aaf2c908d6b8e7f3f7c899916744f545e05733142'
  })

  depends_on 'py3_imapclient'
  depends_on 'py3_olefile'
  depends_on 'py3_tzlocal'
  depends_on 'python3' => :build

  no_source_build
end
