require 'buildsystems/pip'

class Py3_mako < Pip
  description 'Mako is a super fast templating language.'
  homepage 'https://www.makotemplates.org/'
  version "1.3.10-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '818c50197745453cd624af44c0741e0d142059cbd9aff452722498915aee7908',
     armv7l: '818c50197745453cd624af44c0741e0d142059cbd9aff452722498915aee7908',
       i686: '0c276a772390e5cc6f8e30ab2c7075959cdeadcfa8a98225d67ac7523646cb47',
     x86_64: 'e5b2c149f2b3ba4557069f1edacab88b9379cd6cf49ad7b0994a2f7dc17cb1e0'
  })

  depends_on 'py3_markupsafe'
  depends_on 'python3' => :build

  no_source_build
end
