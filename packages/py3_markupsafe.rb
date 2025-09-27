require 'buildsystems/pip'

class Py3_markupsafe < Pip
  description 'Markupsafe allows the safe addition of untrusted strings to HTML/XML markup.'
  homepage 'https://markupsafe.palletsprojects.com/'
  version "3.0.3-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3e7d18ebbfdfe857e91a4230c9bb7256b762e4be51f9afd5a85f8640398c52f2',
     armv7l: '3e7d18ebbfdfe857e91a4230c9bb7256b762e4be51f9afd5a85f8640398c52f2',
       i686: '2d3bdc24e56eabb480202c2d904b4513214b3e9d7e4e302a5b580cc405b30f43',
     x86_64: '0a9024d25c8c712096ccfacf35550e6841d050a12a88db3d53751303bd80d7b7'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
