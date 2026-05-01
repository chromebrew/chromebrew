require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c610a6d55b28d3350017e82cb5af8dcc07d0464b49c20d7fbc7e56ab9fd51778',
     armv7l: 'c610a6d55b28d3350017e82cb5af8dcc07d0464b49c20d7fbc7e56ab9fd51778',
       i686: 'b4910a2e2e4a9231226e43ccd8c3759d898a83c7a51872b6591713ed58759902',
     x86_64: '3d553536fabb0558ddb697a840d9d27de1c7cbe3305951d75ebd65e658bd42c6'
  })

  depends_on 'python3' => :logical

  no_source_build
end
