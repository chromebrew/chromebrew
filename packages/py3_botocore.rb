require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.121-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '95eb6d35a75e5186bb6a95b535160c70904e45e1f1cada2f01a5af6adf2079c8',
     armv7l: '95eb6d35a75e5186bb6a95b535160c70904e45e1f1cada2f01a5af6adf2079c8',
       i686: 'b40c70bc009ec85a7586d9137badb24e0edec0c30c0e48ae4872e9a5efe5b800',
     x86_64: '0f4a27638163408fa2c56c2499d5bb0b1e30b6a7de918bdeffbd1e34e4da6a1c'
  })

  depends_on 'python3' => :logical

  no_source_build
end
