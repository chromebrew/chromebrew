require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  @_ver = '2.1.2'
  version "#{@_ver}-py3.12"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build
  no_compile_needed
  depends_on 'glibc' # R
end
