# NOTE: Archived upstream

require 'buildsystems/pip'

class Py3_terminaltables < Pip
  description 'Terminaltables generates simple tables in terminals from a nested list of strings.'
  homepage 'https://robpol86.github.io/terminaltables/'
  @_ver = '3.1.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_dateutil'
  depends_on 'python3' => :build

  no_compile_needed
end
