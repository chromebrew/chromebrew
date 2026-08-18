require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.73-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ff7ad0347f4d60a15b6b8e7a293c428433ccaddafdcccb5f8ed8dba3ca671fa2',
     armv7l: 'ff7ad0347f4d60a15b6b8e7a293c428433ccaddafdcccb5f8ed8dba3ca671fa2',
       i686: '46eb99d767358c5e533bc273787986b731f9d325a3b261c71b2a69b54117a537',
     x86_64: 'f63d3e2ab34c46275bae0c1d31606027ec0c61870ee6ffb161588aab43a592f7'
  })

  depends_on 'python3' => :logical

  no_source_build
end
