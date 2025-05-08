require 'buildsystems/pip'

class Py3_meson_python < Pip
  description 'Meson Python build backend (PEP 517)'
  homepage 'https://pypi.org/project/meson-python'
  version "0.18.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '833b312dcbd71765874e77dfd9526adec139f4fd25d5c5167c2bd4916f6ec515',
     armv7l: '833b312dcbd71765874e77dfd9526adec139f4fd25d5c5167c2bd4916f6ec515',
       i686: '2ffb2996aa7629932c286af74215f07a9cc3edee2e8dc4661e8b57c17889693e',
     x86_64: '27c165715e20c71561e66365384e02e6c203362880706e127bbd5ab699d344e4'
  })

  depends_on 'python3'

  no_source_build
end
