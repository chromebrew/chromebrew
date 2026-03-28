require 'buildsystems/pip'

class Py3_pyasn1 < Pip
  description 'PyASN.1 is a generic ASN.1 library for Python'
  homepage 'https://github.com/etingof/pyasn1/'
  version "0.6.3-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8e75e5ed25a98ec19c784db5985f20e71db698beaacbdf728cd38453c0f9b860',
     armv7l: '8e75e5ed25a98ec19c784db5985f20e71db698beaacbdf728cd38453c0f9b860',
       i686: '8c58a42447ea9e768f32706b0ca426319c4d0267d79cd0fac3b3452d7183f1f6',
     x86_64: '5edcc9a11d3f006fb98c4d7e7ce36c8b7e0fd2bf2123aaa2b8c8c0987d2e5fb1'
  })

  depends_on 'python3' => :logical

  no_source_build
end
