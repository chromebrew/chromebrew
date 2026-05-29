require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.17-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e15928ec1e75b43d42bf24fb6a24e0d71a18e76003e7a1d9a866b7f4681739a6',
     armv7l: 'e15928ec1e75b43d42bf24fb6a24e0d71a18e76003e7a1d9a866b7f4681739a6',
       i686: '81999041c64618652646559ea75654acc9cbf305375f3aad954d2af00ba6e2ed',
     x86_64: '61f85a1f4baa447eddb3588e395e51822760aaf77b5ee154d7ff8f9eb28877a2'
  })

  depends_on 'python3' => :logical

  no_source_build
end
