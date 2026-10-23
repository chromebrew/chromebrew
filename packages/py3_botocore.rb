require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.118-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c7ee080cb08ad4213a3df28df77d2fd9dd6273fdbc8b50f24267812ddb5f2a4f',
     armv7l: 'c7ee080cb08ad4213a3df28df77d2fd9dd6273fdbc8b50f24267812ddb5f2a4f',
       i686: '74d8897e11de6966a99fc7db21509c4d17769c19140624aa71f26f014c2bed44',
     x86_64: '5b2e393cc04c93751643edc472a5aa1053b91aa25d6d29bc44f10e105f3c7375'
  })

  depends_on 'python3' => :logical

  no_source_build
end
