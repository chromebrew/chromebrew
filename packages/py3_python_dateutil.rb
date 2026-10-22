require 'buildsystems/pip'

class Py3_python_dateutil < Pip
  description 'Dateutil provides extensions to the standard Python datetime module.'
  homepage 'https://dateutil.readthedocs.io/'
  version "3.0.0-#{CREW_PY_VER}"
  license 'BSD-3 and Apache-2.0 or BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ddc3c200821e487a87101dd6f533b0b754eb9f41e6cb209c26968973dddd574c',
     armv7l: 'ddc3c200821e487a87101dd6f533b0b754eb9f41e6cb209c26968973dddd574c',
       i686: 'cb0c35c47233f1f00f44fb083f70ff1f8f511b5f3a5feb1f86d38717ce9eeaca',
     x86_64: 'e87bbcb608560be041eabe3db7fae73a1d6c346ec21dcd9246d62429a088c98f'
  })

  depends_on 'python3' => :logical

  no_source_build
end
