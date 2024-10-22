require 'buildsystems/pip'

class Py3_alabaster < Pip
  description 'Alabaster is a configurable sidebar-enabled Sphinx theme.'
  homepage 'https://alabaster.readthedocs.io/'
  version "1.0.0-#{CREW_PY_VER}"
  license 'BSD' # License is BSD-style, might be BSD-3?
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c69245013f76725cf74115ccd8ee7f69f1fe1264bad8b621e38ec45f0490621c',
     armv7l: 'c69245013f76725cf74115ccd8ee7f69f1fe1264bad8b621e38ec45f0490621c',
       i686: '731e8a1f34bad3c19366bfcb8e23e2759ac39aca3b78b8931b1a47e02dd1f12d',
     x86_64: '14ff489221a96e87522fcecdb6773daa799c7272e69f14a8b6bd46402a2cdc73'
  })

  depends_on 'python3' => :build

  no_source_build
end
