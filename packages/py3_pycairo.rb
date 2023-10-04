require 'buildsystems/python'

class Py3_pycairo < Python
  description 'Pycairo is a provides bindings for the cairo graphics library.'
  homepage 'https://cairographics.org/pycairo/'
  @_ver = '1.25.0'
  version "#{@_ver}-py3.12"
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/pygobject/pycairo.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycairo/1.25.0-py3.12_armv7l/py3_pycairo-1.25.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycairo/1.25.0-py3.12_armv7l/py3_pycairo-1.25.0-py3.12-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycairo/1.25.0-py3.12_x86_64/py3_pycairo-1.25.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b7cc5576a9bd92b01209a26a582f539dad7b4efe375ac1aeeecc6da956e27bc9',
     armv7l: 'b7cc5576a9bd92b01209a26a582f539dad7b4efe375ac1aeeecc6da956e27bc9',
     x86_64: '697c5507743e106e677c9a3ed48802071a3a20a80cc40a62761e5e256bed0b49'
  })

  depends_on 'cairo'
  depends_on 'libxxf86vm'
  depends_on 'libxrender'
  depends_on 'python3' => :build
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
end
