require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.8.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3f0aa06f2ae112f9f61f788c3a1f27d8d02f2a0b461b2eb2420beb776f7d8e4c',
     armv7l: '3f0aa06f2ae112f9f61f788c3a1f27d8d02f2a0b461b2eb2420beb776f7d8e4c',
       i686: 'aac47544263ddec8dbcc816449eaf65abee984b1dd21e400f653a888121691c8',
     x86_64: '7fcc2da44a850ef4e37b2554cd1fb92195eb71389b7c7b027c9726fb035d909f'
  })

  depends_on 'ninja'
  depends_on 'python3'

  no_source_build
end
