require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.44.3-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '627026f39a7784188a97942fff109e78ae5518b37b9ce98d431b233102f339eb',
     armv7l: '627026f39a7784188a97942fff109e78ae5518b37b9ce98d431b233102f339eb',
       i686: 'aab46cb59cecaaa0750bff6bfe9f89131a2d1ea7771fe964278de5e2838613a1',
     x86_64: '84aa76fb2eb4bbccc5e0e263f0239f9b893fe4fd0039220e9a3c66e0cc4f4f22'
  })

  depends_on 'python3' => :logical

  no_source_build
end
