require 'buildsystems/pip'

class Py3_nodeenv < Pip
  description 'Tool to create isolated node.js environments.'
  homepage 'https://github.com/ekalinin/nodeenv'
  version '1.9.1-py3.12'
  license 'Copyright (c) 2011, Eugene Kalinin'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3'

  no_source_build
end
