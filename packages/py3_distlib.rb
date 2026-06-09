require 'buildsystems/pip'

class Py3_distlib < Pip
  description 'Distlib provides distribution utilities for Python packages.'
  homepage 'https://bitbucket.org/pypa/distlib/'
  version "0.4.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ef1a03136c4b063003ee304097e4e296454c5188bf92141a3de4fa86c2033912',
     armv7l: 'ef1a03136c4b063003ee304097e4e296454c5188bf92141a3de4fa86c2033912',
       i686: '26b3cf200c7b7c2ea6d9be9c0f5e21b398c7fef55af0d24752e542d030a0ab3f',
     x86_64: 'b577f8ee85a179db2701626da60041b914fd48b8f556cd944156143d36703e6f'
  })

  depends_on 'python3' => :logical

  no_source_build
end
