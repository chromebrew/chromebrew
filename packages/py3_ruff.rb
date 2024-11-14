require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.7.3-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8f08bd7f61b17013bd2296653fdb49283168af8f1542e26f495445d21d4a5e8d',
     armv7l: '8f08bd7f61b17013bd2296653fdb49283168af8f1542e26f495445d21d4a5e8d',
       i686: 'c396482f683d3bb1f917939ed68cfd0c6626e77fc033fd18926322289a29efa2',
     x86_64: '6c2a65e90c836002983599c133003608d18a1b1885f7f2b3d4b79976500e9183'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'rust' => :build

  no_source_build
end
