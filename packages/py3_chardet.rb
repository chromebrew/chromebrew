require 'buildsystems/pip'

class Py3_chardet < Pip
  description 'Chardet is a universal encoding detector.'
  homepage 'https://github.com/chardet/chardet/'
  version "7.4.3-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5dd27fa804f5227ae35d6f651e3b460c03b29e1dd8a74a2806929cc9baf22cd7',
     armv7l: '5dd27fa804f5227ae35d6f651e3b460c03b29e1dd8a74a2806929cc9baf22cd7',
       i686: '049e7e141ffa0d2fbbbb26e9695ab1207813025d48d0338a433492c3bc6db692',
     x86_64: '8dd1e7916435f11073001363029b48ee579117b8a9c8fc4a38fda2e48149a7fe'
  })

  depends_on 'glibc' => :library
  depends_on 'python3' => :logical

  no_source_build
end
