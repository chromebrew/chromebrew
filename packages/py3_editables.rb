require 'buildsystems/pip'

class Py3_editables < Pip
  description 'A Python library for creating "editable wheels"'
  homepage 'https://editables.readthedocs.io'
  version '0.5-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8c6d70dd0b64b3de408c01fad2e19d96e8dba387198a2af0ea55e70a9e918600',
     armv7l: '8c6d70dd0b64b3de408c01fad2e19d96e8dba387198a2af0ea55e70a9e918600',
       i686: '191a4283041998cbf3dcc0ba234ec2e1cc1e643626835d009506c3b7fed87bbc',
     x86_64: '71632e325a2e116ebc2608077e945d3cd6f0cc92124183bef07c7f4c722f7ebd'
  })

  depends_on 'python3' => :build

  no_source_build
end
