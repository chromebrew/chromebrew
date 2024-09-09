require 'buildsystems/pip'

class Py3_toml < Pip
  description 'Toml is a Python Library for Tom\'s Obvious, Minimal Language.'
  homepage 'https://github.com/uiri/toml/'
  version '0.10.2-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '73985b46316ff4b0ef5cb48ec0f5fafff932dfe28ab77012d5a64b5e6beffe4d',
     armv7l: '73985b46316ff4b0ef5cb48ec0f5fafff932dfe28ab77012d5a64b5e6beffe4d',
       i686: 'e73e1239eb52a1c039424be381a1db0c82fd604fcdd895115aca81beaefad2f0',
     x86_64: '5d71737ff5a60a81e04942be544e2c0dff21274d2130d4d0716de247350aa49c'
  })

  depends_on 'python3' => :build

  no_source_build
end
