require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.94-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '846157c229567f43b6a2d10c714fc2f71889edc16ac7df053467c27056abdc6f',
     armv7l: '846157c229567f43b6a2d10c714fc2f71889edc16ac7df053467c27056abdc6f',
       i686: 'e359ff9f5164b496232e68e788a17d8e858b024e42abf185563da1aed3745f20',
     x86_64: 'a0f6c370910aedebc70bc0f45e9f553b94719b73fabe0737fe76a6b8f2508671'
  })

  depends_on 'python3' => :logical

  no_source_build
end
