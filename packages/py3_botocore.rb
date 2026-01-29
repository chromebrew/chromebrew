require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.37-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b6a2a5750c109f105c5a344c1e11cb5551b64f88d16a71823032ff4388a5198c',
     armv7l: 'b6a2a5750c109f105c5a344c1e11cb5551b64f88d16a71823032ff4388a5198c',
       i686: '7ea7ac4bfb8dda434b9175fa84da08a79ee09cdf8d05ea395efce7bd36bf5248',
     x86_64: '8e5a44a535ba519f21247768dda44eeef7edacc4e795bb03b18e26709c9b130e'
  })

  depends_on 'python3' => :build

  no_source_build
end
