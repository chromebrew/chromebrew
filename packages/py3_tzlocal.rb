require 'buildsystems/pip'

class Py3_tzlocal < Pip
  description 'Tzlocal provides tzinfo object for the local timezone.'
  homepage 'https://github.com/regebro/tzlocal/'
  version "5.3.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6f21c5329d8b8b4b492f54f037734c326117947d078f6b32b9cdd1dcaefe2e3c',
     armv7l: '6f21c5329d8b8b4b492f54f037734c326117947d078f6b32b9cdd1dcaefe2e3c',
       i686: '5edad6d31c6ef64ff5a14025a8a64e9574b9b734af2bf94346d906937486365e',
     x86_64: 'bf1c22bd9375cc2a57598373f7c2ff83024a7cc763bcde73607f653f3cf6e855'
  })

  depends_on 'py3_pytz'
  depends_on 'python3' => :logical

  no_source_build
end
