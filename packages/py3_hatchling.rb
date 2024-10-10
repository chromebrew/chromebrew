require 'buildsystems/pip'

class Py3_hatchling < Pip
  description 'The extensible, standards compliant build backend used by Hatch.'
  homepage 'https://hatch.pypa.io/latest'
  version "1.25.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f8f17f42cecca5f8ad2997a7650974d0bbb7c0ef14ece61038fdd86ba81a874f',
     armv7l: 'f8f17f42cecca5f8ad2997a7650974d0bbb7c0ef14ece61038fdd86ba81a874f',
       i686: '4670ef4d33c20d9db56f31a392b8707929011beba6786b78a6d9564f4d711bf6',
     x86_64: 'c4f86d9377d52c97c23def6062508954bdac0f17b2c46ce0cc50fd78cebfa5b4'
  })

  depends_on 'py3_editables'
  depends_on 'py3_pathspec'
  depends_on 'py3_pluggy'
  depends_on 'py3_trove_classifiers'
  depends_on 'python3' => :build

  no_source_build
end
