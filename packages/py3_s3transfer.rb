require 'buildsystems/pip'

class Py3_s3transfer < Pip
  description 'An Amazon S3 Transfer Manager'
  homepage 'https://github.com/boto/s3transfer'
  version "0.19.3-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd35dca28cf9de93f010d7833c215722ffe81a118ac43749c1c1edfaeda4bfa81',
     armv7l: 'd35dca28cf9de93f010d7833c215722ffe81a118ac43749c1c1edfaeda4bfa81',
       i686: '528f949ec01c7203b8415991b876d80caf6bb0468ffb5f11ce6c0e7b46d0518f',
     x86_64: 'e9417d6c9081ccb8268b42dfabbf195a16dda7c9678deaafb296fdf1c0140f2c'
  })

  depends_on 'python3' => :logical

  no_source_build
end
