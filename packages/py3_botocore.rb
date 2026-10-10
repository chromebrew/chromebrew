require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.110-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eac301f6ebb80507d488f2a2146622552639daee86445d4c0bca603e7bb95b42',
     armv7l: 'eac301f6ebb80507d488f2a2146622552639daee86445d4c0bca603e7bb95b42',
       i686: '2efa8f6834f7df0fb7614dca0cf1eaddc1e60ffc2880a1bd3f204b15c5ea3274',
     x86_64: '17a17fb6b5ee4565acb16ebaa76a4686a23f7f0497e46600135fca18ec5fe9a5'
  })

  depends_on 'python3' => :logical

  no_source_build
end
