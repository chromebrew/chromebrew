require 'buildsystems/pip'

class Py3_cffi < Pip
  description 'C Foreign Function Interface for Python calling C code.'
  homepage 'https://cffi.readthedocs.io/'
  version "2.1.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/python-cffi/cffi.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8668f9a04427fe51d149d0f56f9869e5125721a33262a65cc8daa2764eb6c180',
     armv7l: '8668f9a04427fe51d149d0f56f9869e5125721a33262a65cc8daa2764eb6c180',
       i686: '58290f8a2711fb5502f4b1aa259821831f72b471ebe19e8272c6e21301bebc72',
     x86_64: '399553783f7c5f64e4a42f824375da096663db00b9ea359f9034a3ddb9755429'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libffi' => :library
  depends_on 'python3' => :logical

  no_fhs
end
