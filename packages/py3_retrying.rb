require 'buildsystems/pip'

class Py3_retrying < Pip
  description 'Retrying simplifies the task of adding retry behavior to just about anything.'
  homepage 'https://github.com/rholder/retrying/'
  version "1.4.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b3ec720c2d5e1f61fb4aee13c0c23fde3c8d6b394a0d85dc5a6442d338dabfdf',
     armv7l: 'b3ec720c2d5e1f61fb4aee13c0c23fde3c8d6b394a0d85dc5a6442d338dabfdf',
       i686: 'aad6b8aff93c47586f56cd3c681da81e3efe5d2384f9d9b6b0490cbd8746705e',
     x86_64: '15e07394f61124813fdb59596edebe00f8ccba3d7792c13ed86a15bb5448994c'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
