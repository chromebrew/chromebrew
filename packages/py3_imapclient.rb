require 'buildsystems/pip'

class Py3_imapclient < Pip
  description 'IMAPclient is an easy-to-use, complete IMAP client library.'
  homepage 'https://imapclient.readthedocs.io/'
  @_ver = '2.2.0'
  version "#{@_ver}-py3.12"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_six'
  depends_on 'python3' => :build
  no_compile_needed
end
