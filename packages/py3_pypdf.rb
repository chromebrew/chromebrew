require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.1.2-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3badded32f32c215d195ba31bfc562ec86aee546903e9655b8ccad54aa6c0c55',
     armv7l: '3badded32f32c215d195ba31bfc562ec86aee546903e9655b8ccad54aa6c0c55',
       i686: '307092f986a0499e1425e97c0845b6e26ba035c109b03c30f0fb766b6e72d384',
     x86_64: '68b709396478ab171750c2663bcb4e6e5d4bfd3a5319b80fc112ab7f01678218'
  })

  depends_on 'python3'

  no_source_build
end
