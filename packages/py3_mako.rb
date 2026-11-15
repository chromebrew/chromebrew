require 'buildsystems/pip'

class Py3_mako < Pip
  description 'Mako is a super fast templating language.'
  homepage 'https://www.makotemplates.org/'
  version "1.4.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3ad70f08c49e63ef50a1ab3d68bc9c1f0ef920a77e920c483112e2e007474668',
     armv7l: '3ad70f08c49e63ef50a1ab3d68bc9c1f0ef920a77e920c483112e2e007474668',
       i686: '28d2b78de5bb52be2c3e3dacc52163aa14152bd89964f2057c804ed00977bef8',
     x86_64: '8b91681a6a068b00a8ce28f54cb7f64a18b6fa31b284d7ddfe77c3898cda5b39'
  })

  depends_on 'py3_markupsafe'
  depends_on 'python3' => :logical

  no_source_build
end
