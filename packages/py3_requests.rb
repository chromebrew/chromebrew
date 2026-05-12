require 'buildsystems/pip'

class Py3_requests < Pip
  description 'Requests is a simple, yet elegant, HTTP library.'
  homepage 'https://docs.python-requests.org/'
  version "2.34.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9527de3f1eb0ba598a9fa4c9fc5cdee1d5ba752f8397a3cd567334d3a0a75fe2',
     armv7l: '9527de3f1eb0ba598a9fa4c9fc5cdee1d5ba752f8397a3cd567334d3a0a75fe2',
       i686: 'eb820740a5bfc216cf743a81aa1b0a3800147c1ae5502ae24c0f97b37f396cd7',
     x86_64: '22f1a8c3e0e99f1624aa95967611ab3ab855894549319b62f11f0838311e4289'
  })

  depends_on 'py3_charset_normalizer'
  depends_on 'py3_idna'
  depends_on 'py3_urllib3'
  depends_on 'python3' => :logical

  no_source_build
end
