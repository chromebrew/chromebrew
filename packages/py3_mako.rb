require 'buildsystems/pip'

class Py3_mako < Pip
  description 'Mako is a super fast templating language.'
  homepage 'https://www.makotemplates.org/'
  version '1.3.5-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '158fa2d2305ab23b5a6e41833df0009ef0b1d65c6a467f577a6113f6e16d891b',
     armv7l: '158fa2d2305ab23b5a6e41833df0009ef0b1d65c6a467f577a6113f6e16d891b',
       i686: 'fb23ce1fc5c2ac1c1d3913c7902a797383e12a08e60576d155c0aa7b69dd7f9d',
     x86_64: '064855203ff158c32f157c4adf9d7205e2cce795c7089447cdb776902bec96e2'
  })

  depends_on 'py3_markupsafe'
  depends_on 'python3' => :build

  no_source_build
end
