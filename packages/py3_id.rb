require 'buildsystems/pip'

class Py3_id < Pip
  description 'Python tool for generating OIDC identities.'
  homepage 'https://pypi.org/project/id'
  version "1.6.1-#{CREW_PY_VER}"
  license 'Apache'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '370edb0be981cfb2727ae1da7ad5af5849d3d48d9c849964e2ade6261b7b4417',
     armv7l: '370edb0be981cfb2727ae1da7ad5af5849d3d48d9c849964e2ade6261b7b4417',
       i686: '1054dc15a64868d494ca5f49fd844513661b69166b8e1f390135fb083ac551bc',
     x86_64: '5bf6717080a49e2ac1ae0e5ea8abdca1901f3e6c5906f2a8e424c6017d891d1c'
  })

  depends_on 'python3' => :build

  no_source_build
end
