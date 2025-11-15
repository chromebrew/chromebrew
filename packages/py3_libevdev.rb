require 'buildsystems/pip'

class Py3_libevdev < Pip
  description 'Libevdev is a Python wrapper around the libevdev C library.'
  homepage 'https://python-libevdev.readthedocs.io/'
  version "0.13.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '112683492bc39bda0ba1f3c1537c3a6108f123f89ed3d37ca284ec5ca13262a4',
     armv7l: '112683492bc39bda0ba1f3c1537c3a6108f123f89ed3d37ca284ec5ca13262a4',
       i686: '26cc8d92f25b555133e8321ecff4d20038ae93c7496687ee2b2c3c59225cc644',
     x86_64: 'b4dc771ec18fb3baa514fdc2d8660cd41586ccc2c27e95d9c0883dd99fc587fb'
  })

  depends_on 'python3' => :build

  no_source_build
end
