require 'buildsystems/pip'

class Py3_markupsafe < Pip
  description 'Markupsafe allows the safe addition of untrusted strings to HTML/XML markup.'
  homepage 'https://markupsafe.palletsprojects.com/'
  @_ver = '2.0.1'
  version "#{@_ver}-py3.12"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'glibc' # R
  depends_on 'python3' => :build
  no_compile_needed
end
