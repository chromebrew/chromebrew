require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.6.9-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '97a8b709e6689874e4be6a7ddb047917c59a454ba475d592d8f357f171bf8254',
     armv7l: '97a8b709e6689874e4be6a7ddb047917c59a454ba475d592d8f357f171bf8254',
       i686: 'fa50a614bbc482117d73845a864b6130167c831657589dec83a24addd6222365',
     x86_64: 'b48986881d7210b8f6cf44acf08949947b424779046b041a720c5ed3af4e4e76'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'rust' => :build

  no_source_build
end
