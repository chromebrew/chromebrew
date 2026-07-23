require 'buildsystems/pip'

class Py3_s3transfer < Pip
  description 'An Amazon S3 Transfer Manager'
  homepage 'https://github.com/boto/s3transfer'
  version "0.19.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2e2ebb949b0636db8f2534fb170fcd51ee41909217f186817112262c83d3567e',
     armv7l: '2e2ebb949b0636db8f2534fb170fcd51ee41909217f186817112262c83d3567e',
       i686: 'a2eb663d96c7e40ee5638a4c18ead16ef21e60ed92d3fe62698f8c9dfbe371fc',
     x86_64: '9bf2c552378fb55ddcd889dcc5e12665dbeba938b15a13fd6b4be38bcbf452db'
  })

  depends_on 'python3' => :logical

  no_source_build
end
