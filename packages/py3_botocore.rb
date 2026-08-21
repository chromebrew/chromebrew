require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.76-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6aaec74a5a518332440b3353d7a9ea6678935cd7b6fdc6013512cd3b0cb67de2',
     armv7l: '6aaec74a5a518332440b3353d7a9ea6678935cd7b6fdc6013512cd3b0cb67de2',
       i686: '17bc7f91c4bbee4251e526b7b65833cbc225351cf1ee4bd69e0c39acbb751187',
     x86_64: '44dac298591c6d7ab34fad1bc0b0a3511e5b839c0ec72876cf9249741d758c99'
  })

  depends_on 'python3' => :logical

  no_source_build
end
