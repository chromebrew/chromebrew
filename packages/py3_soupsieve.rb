require 'buildsystems/pip'

class Py3_soupsieve < Pip
  description 'CSS selector library designed to be used with Beautiful Soup 4.'
  homepage 'https://github.com/facelessuser/soupsieve'
  version "2.8.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c4dccdf0a108a826aee95e34ff00552f59ad3405f64aa81d321b2068580d9aa4',
     armv7l: 'c4dccdf0a108a826aee95e34ff00552f59ad3405f64aa81d321b2068580d9aa4',
       i686: '668b6182e3b06c3b3cd1b3074d458cd86e42c7abbd48e797d00898bcda31813e',
     x86_64: 'd54fb8c45b0bb8629f3256b69d338feeda41e8a5c8e75db58f4d51a3398f068f'
  })

  depends_on 'python3' => :build

  no_source_build
end
