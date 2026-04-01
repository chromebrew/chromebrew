require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.80-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4cffe1de165606df59504c80018755004343f1ab2b9badbbdef8dd46308f601d',
     armv7l: '4cffe1de165606df59504c80018755004343f1ab2b9badbbdef8dd46308f601d',
       i686: '7abc5a67ed0917bea27f30e5002bac5c6aff216e938a14aadfea158310a3dd54',
     x86_64: '2f8b8ec269ec745406f747153939c701ebf6b7bbbf358f594dfda7b73ac9676f'
  })

  depends_on 'python3' => :logical

  no_source_build
end
