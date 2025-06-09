require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.8.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a17ab93a2318b6416893819a8ae8ef7e53715f2636f9f80bace1a03f6811c0b6',
     armv7l: 'a17ab93a2318b6416893819a8ae8ef7e53715f2636f9f80bace1a03f6811c0b6',
       i686: 'b49e17456c4d1c3d53f5dfdb480a5a5ca9232d7d841bb831d202360667df27da',
     x86_64: 'f0b1a0444b499a103a4bb5589957c8661af1eb118f4e4e9a4376df60b93ea274'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'python3'

  no_source_build
end
