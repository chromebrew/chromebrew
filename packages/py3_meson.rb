require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.9.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '25eaf59950dadcbcce0bee30bf89b2fbdb763bb8a40be6b82d0853176dbf04e1',
     armv7l: '25eaf59950dadcbcce0bee30bf89b2fbdb763bb8a40be6b82d0853176dbf04e1',
       i686: 'aab899fef2476905388192bfd03859828d3d6ac03240cc82418f9faa29933fdf',
     x86_64: '4842eff57b79f607d359ab9427fc608cf8f3d7740114eb32ddccf3359bc47af5'
  })

  depends_on 'ninja'
  depends_on 'python3'

  no_source_build
end
