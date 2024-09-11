require 'buildsystems/pip'

class Py3_nodeenv < Pip
  description 'Tool to create isolated node.js environments.'
  homepage 'https://github.com/ekalinin/nodeenv'
  version '1.9.1-py3.12'
  license 'Copyright (c) 2011, Eugene Kalinin'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f70fd891b47a2d87726bb6871f62f62af46e9c55219b1cc6c580cd769bdd3a87',
     armv7l: 'f70fd891b47a2d87726bb6871f62f62af46e9c55219b1cc6c580cd769bdd3a87',
       i686: 'f5fb2788a14188723871f4e63d0a0992c79883be66a0a5d7ea3095604342a326',
     x86_64: '45d48d6bf07fee6eb93c66cae1d7c2df563b7dc3dee43996f886d746fbe7103d'
  })

  depends_on 'python3'

  no_source_build
end
