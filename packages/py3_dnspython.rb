require 'buildsystems/python'

class Py3_dnspython < Python
  description 'DNSPython is a DNS toolkit.'
  homepage 'https://www.dnspython.org/'
  @_ver = '2.4.2'
  version "#{@_ver}-py3.12"
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/rthalley/dnspython.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ef5f94b2f6f6fa5093e74bb51e122f107ef0578d9a7b4002f6c771a1bccc531a',
     armv7l: 'ef5f94b2f6f6fa5093e74bb51e122f107ef0578d9a7b4002f6c771a1bccc531a',
       i686: '708c59b55967c652f7df27cfa12080886f7c11f19d9938b11b9f334d871399d2',
     x86_64: '5c1259ad9779ee76e91b8edec0ab27080dc4dd3797f2e4ba615c50349546e334'
  })

  depends_on 'python3' => :build
end
