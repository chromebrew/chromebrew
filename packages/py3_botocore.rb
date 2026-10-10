require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.111-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eba28dc167b793080136687ceea7d0272961e3dc02db65ce9b4a5f2015776727',
     armv7l: 'eba28dc167b793080136687ceea7d0272961e3dc02db65ce9b4a5f2015776727',
       i686: 'cc0fa04f86dc770af4d6e3d9a76caa8b93b0bdbd8251f10bec1d59f69d3e2127',
     x86_64: '4a6edc19705579ddddcde3c5b820da90014ca2619053e9ad41d35d7dfd426947'
  })

  depends_on 'python3' => :logical

  no_source_build
end
