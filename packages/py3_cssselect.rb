require 'buildsystems/pip'

class Py3_cssselect < Pip
  description 'CSSselect parses CSS3 Selectors and translates them to XPath 1.0.'
  homepage 'https://cssselect.readthedocs.io/'
  version "1.5.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fe098d1d4e676c3bc7d2271bb83749a7def2e48aa0837ab6e86efd30526c0df2',
     armv7l: 'fe098d1d4e676c3bc7d2271bb83749a7def2e48aa0837ab6e86efd30526c0df2',
       i686: 'b4c15548c4da259f0fa5434b5e9407562a96e3d75c159e841db6f5fe570cef5a',
     x86_64: 'f8e89bc2945099ae36f8df343ca3db316e09a967198ad2ea3b4d5720478874ab'
  })

  depends_on 'python3' => :logical

  no_source_build
end
