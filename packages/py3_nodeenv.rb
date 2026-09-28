require 'buildsystems/pip'

class Py3_nodeenv < Pip
  description 'Tool to create isolated node.js environments.'
  homepage 'https://github.com/ekalinin/nodeenv'
  version "1.11.0-#{CREW_PY_VER}"
  license 'Copyright (c) 2011, Eugene Kalinin'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '43a13c5ece0de1e98b0ee3c472cec191924d1efad2fc49bd8b82ca6db3acc733',
     armv7l: '43a13c5ece0de1e98b0ee3c472cec191924d1efad2fc49bd8b82ca6db3acc733',
       i686: 'e5f36dda39899bb8be811da141b70392f463e30f4538beceb4f1068861bb4143',
     x86_64: '2ec8b748c622b60975e4da7f194ea719a5298fa59b917a8e611da206106b6fc5'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
