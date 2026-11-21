require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.44.8-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b89b5d71ac7f7eeafb815c3db089caf17c485a7886eae45f3d4d040522073acd',
     armv7l: 'b89b5d71ac7f7eeafb815c3db089caf17c485a7886eae45f3d4d040522073acd',
       i686: 'bfe31374b8630d3825d455be4b581e307c4aa78670f4a4f758274f1772f7827c',
     x86_64: 'b437bb34c6a7e49b50d1f73443e63eb8a082d24305ccd9da45cace9497e7262a'
  })

  depends_on 'python3' => :logical

  no_source_build
end
