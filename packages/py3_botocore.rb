require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.31-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b1f292ad75f5e8e36afeb13090fcb274eec9e79f7c963007efa013581873e179',
     armv7l: 'b1f292ad75f5e8e36afeb13090fcb274eec9e79f7c963007efa013581873e179',
       i686: '689035adff2323c181e259f90a38f34c3b5efbd91210efb8b697bcee5c477618',
     x86_64: '9323af22a571b230bd85748242094449bc63bfc395f180fed6c86353238b17dd'
  })

  depends_on 'python3' => :build

  no_source_build
end
