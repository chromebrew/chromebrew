require 'buildsystems/pip'

class Py3_psutil < Pip
  description 'psutil is a cross-platform library for process and system monitoring in Python.'
  homepage 'https://github.com/giampaolo/psutil/'
  version "7.1.3-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'debeb6a8369c7e8be48245901c060ee2aca4d7f9be961344997b765d79c97c41',
     armv7l: 'debeb6a8369c7e8be48245901c060ee2aca4d7f9be961344997b765d79c97c41',
       i686: 'b67814742cc0640b1f81f0f777033ec2f766dc4bf565d3e11a7178aebc635359',
     x86_64: 'f16c350d03d51ddaa3f5154d9b0555ad3ecdb797c06935985e6d007afbfb00fc'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
