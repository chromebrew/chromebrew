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
    aarch64: 'b1d7f39b7cc5478cc2933ba4ae0a8dc24561a8513078f305ad443803e6d82f46',
     armv7l: 'b1d7f39b7cc5478cc2933ba4ae0a8dc24561a8513078f305ad443803e6d82f46',
       i686: '8ae7bbf26ead1edf083b8d5f9c5940169864e699e06cf160a691b1a48b5de518',
     x86_64: '3b621c86920ef03c0692775350198d68c0a2ef03572c296287c64e2b1bf86e78'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
