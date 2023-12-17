require 'buildsystems/python'

class Py3_nodeenv < Python
  description 'Tool to create isolated node.js environments.'
  homepage 'https://github.com/ekalinin/nodeenv'
  @_ver = '1.8.0'
  version "#{@_ver}-py3.12"
  license 'Copyright (c) 2011, Eugene Kalinin'
  compatibility 'all'
  source_url 'https://github.com/ekalinin/nodeenv.git'
  git_hashtag @_ver

  depends_on 'python3'

  no_compile_needed
end
