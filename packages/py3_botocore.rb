require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.10-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '33e78598c95a0a960d27f7203d52c604df48a59d034125d50665e97cd7cda540',
     armv7l: '33e78598c95a0a960d27f7203d52c604df48a59d034125d50665e97cd7cda540',
       i686: 'd5279988925f0dea8cfdb46cea3d59bd3e1c59790b365c6db4c467a0ddc7b9d6',
     x86_64: '989e19a41dec6e953869c8155a49799eac68647bf81a0efafa0865e0a39587ff'
  })

  depends_on 'python3' => :logical

  no_source_build
end
