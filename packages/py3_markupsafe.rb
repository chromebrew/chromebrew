require 'buildsystems/pip'

class Py3_markupsafe < Pip
  description 'Markupsafe allows the safe addition of untrusted strings to HTML/XML markup.'
  homepage 'https://markupsafe.palletsprojects.com/'
  version "3.0.1-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0f860e9efeba31e5c3bc1d9d47200d7da2503a7fbb64f742921feed3d3d49d82',
     armv7l: '0f860e9efeba31e5c3bc1d9d47200d7da2503a7fbb64f742921feed3d3d49d82',
       i686: '96d52431e0d413712b605c4fd239059749542dbe6e7baee88f2217b2ed405476',
     x86_64: '607261c8042c664dd7231b8df54d72462af375b8a1bfc71a5c57fc140174b976'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
