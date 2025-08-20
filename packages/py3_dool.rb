require 'buildsystems/pip'

class Py3_dool < Pip
  description 'Dool is a command line tool to monitor many aspects of your system: CPU, Memory, Network, Load Average, etc.'
  homepage 'https://github.com/scottchiefbaker/dool'
  version "1.3.6-#{CREW_PY_VER}"
  license 'GPL3+'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3'

  no_compile_needed
end
