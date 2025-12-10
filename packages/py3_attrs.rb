require 'buildsystems/pip'

class Py3_attrs < Pip
  description 'Attrs removes the need to implement object protocols in classes.'
  homepage 'https://www.attrs.org/'
  version "25.4.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '31fd75a4ddc5c554fa9d3d6c06eaca1dcde1293498bfbe62127cb719b926184a',
     armv7l: '31fd75a4ddc5c554fa9d3d6c06eaca1dcde1293498bfbe62127cb719b926184a',
       i686: '79d1fa86da0956db415d1ffa58af6ce172ac1ddf96206523cee00a3d7b9bfdaa',
     x86_64: '3412ff5210e5d010755236beb8c580c2464109ef972221d0aad2f330ce24a212'
  })

  depends_on 'python3' => :build
  depends_on 'py3_hatchling' => :build
  depends_on 'py3_hatch_vcs' => :build

  no_source_build
end
