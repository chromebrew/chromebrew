require 'buildsystems/pip'

class Py3_markupsafe < Pip
  description 'Markupsafe allows the safe addition of untrusted strings to HTML/XML markup.'
  homepage 'https://markupsafe.palletsprojects.com/'
  version "2.1.5-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '91e5abb3d3c30d32388242d36a8e762e9aeb53b19fdf9b632b8eba98f8613c2d',
     armv7l: '91e5abb3d3c30d32388242d36a8e762e9aeb53b19fdf9b632b8eba98f8613c2d',
       i686: 'c414b61c12085527d1615acdff9e35e9f10a468ea2b71d7663ed0c160c0aa4ab',
     x86_64: 'c5a3ddc87afe1c084c4af5c1ee4a5da9c98659648fc9b24a1a320cde7c7a9602'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
