require 'buildsystems/pip'

class Py3_imagesize < Pip
  description 'Imagesize gets image size from png/jpeg/jpeg2000/gif file.'
  homepage 'https://github.com/shibukawa/imagesize_py/'
  version "1.4.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '496b7868dcafd439f2be6c27e1a350b548c0dd3f64cdee6b54271583b7c1e752',
     armv7l: '496b7868dcafd439f2be6c27e1a350b548c0dd3f64cdee6b54271583b7c1e752',
       i686: 'ebbee91dd8289110f28efc3aea74574246c64fcc9d9e6a777b3f1dfaa04113ea',
     x86_64: 'dff67e0990826aaf6fa95348508d8290a67b3d3ad2156ca37b1c427c6d72643f'
  })

  depends_on 'python3' => :build

  no_source_build
end
