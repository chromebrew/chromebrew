require 'buildsystems/pip'

class Py3_attrs < Pip
  description 'Attrs removes the need to implement object protocols in classes.'
  homepage 'https://www.attrs.org/'
  version "25.3.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd17163db6cb1b6679b058c777f38a2ba48dedae1093b303510f4a48455e77a7c',
     armv7l: 'd17163db6cb1b6679b058c777f38a2ba48dedae1093b303510f4a48455e77a7c',
       i686: '4e8e341b277816ba05150a1eb2029b66d23a6d0ce0ffe6e3a19ac8fd09528ed6',
     x86_64: '7c9c1686f125127158da2ab787020d1eccba93978eb9c8ecbf0de5ce4e8a1c77'
  })

  depends_on 'python3' => :build
  depends_on 'py3_hatchling' => :build
  depends_on 'py3_hatch_vcs' => :build

  no_source_build
end
