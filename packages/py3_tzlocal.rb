require 'buildsystems/pip'

class Py3_tzlocal < Pip
  description 'Tzlocal provides tzinfo object for the local timezone.'
  homepage 'https://github.com/regebro/tzlocal/'
  version "5.4.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '10b0a954695da6c4d58325d0ffd07b2bddcf0fbb04919c5e0301e36165b26cc2',
     armv7l: '10b0a954695da6c4d58325d0ffd07b2bddcf0fbb04919c5e0301e36165b26cc2',
       i686: '9bc792703ff585f454a85b3ee22f343b970648414919a7779971200434dc71a1',
     x86_64: '1596bc0d32a5055d2293d4a11019130a13a035ad1767599d0b9554f1d7cc5a26'
  })

  depends_on 'py3_pytz'
  depends_on 'python3' => :logical

  no_source_build
end
