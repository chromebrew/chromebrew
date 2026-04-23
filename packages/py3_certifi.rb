require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2026.4.22-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8b8cce9425c7873da4a5076787a4bc7a39c69f47c6e436b1b13b2d50977be1c0',
     armv7l: '8b8cce9425c7873da4a5076787a4bc7a39c69f47c6e436b1b13b2d50977be1c0',
       i686: '0cf4e110526ca29813e2a0ac3bd386ab057b36436d033c021372c61d259301ab',
     x86_64: 'c38c9067a647dbe9d63227e4f4533e904ab2e78cac9d5e38f71338df5bb0cc02'
  })

  depends_on 'python3' => :logical

  no_source_build
end
