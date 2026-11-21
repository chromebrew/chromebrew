require 'buildsystems/pip'

class Py3_pyyaml < Pip
  description 'PyYAML is a YAML parser and emitter for Python.'
  homepage 'https://pyyaml.org/'
  version "6.0.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c403278ad27da8780f4e2096fdda7597433fef003d55554eaa49d0a5e313a727',
     armv7l: 'c403278ad27da8780f4e2096fdda7597433fef003d55554eaa49d0a5e313a727',
       i686: 'b605c8368ff8048115e1ecb9db62a2d8a1b9c1bb8ea86c4ebac029912cc176f5',
     x86_64: '7c5f6a627d59e9f83c8eb95bf9569de6eb315741e27e2968edfef68cca0dcec3'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libyaml' => :library
  depends_on 'python3' => :logical

  no_source_build
end
