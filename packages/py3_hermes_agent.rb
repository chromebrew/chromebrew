require 'buildsystems/pip'

class Py3_hermes_agent < Pip
  description 'The self-improving AI agent'
  homepage 'https://hermes-agent.nousresearch.com/'
  version "0.15.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8acb43f7464dbe2a6141cd011d07b6d8fbd09ca3af6fe3ee0c6019390bd7185e',
     armv7l: '8acb43f7464dbe2a6141cd011d07b6d8fbd09ca3af6fe3ee0c6019390bd7185e',
       i686: '98efa53fbe5cd306ad199ed951a461dd0d8bbe8c568f7a361a1a1ad3d9e5125d',
     x86_64: '8b95f49b136d48d42186e7e725420b7258af24c16d5162538dbc8dc192491401'
  })

  depends_on 'python3' => :logical

  no_source_build
end
