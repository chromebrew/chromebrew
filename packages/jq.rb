require 'buildsystems/autotools'

class Jq < Autotools
  description 'jq is a lightweight and flexible command-line JSON processor.'
  homepage 'https://stedolan.github.io/jq/'
  version '1.8.0'
  license 'MIT and CC-BY-3.0'
  compatibility 'all'
  source_url 'https://github.com/stedolan/jq.git'
  git_hashtag "jq-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e9cb268eb4ecd0f60e630b6f9803ac98786bdcd3abd03f4b4491daea0d1b9e1e',
     armv7l: 'e9cb268eb4ecd0f60e630b6f9803ac98786bdcd3abd03f4b4491daea0d1b9e1e',
       i686: 'd3f0160e353fa8abb5f05a67706f7c6ba98897e03db42ffffcde5b90920d7160',
     x86_64: 'bcb53c60671bf683e358d4ed1eb1d65ac892a157070278844e0627944b205877'
  })

  depends_on 'glibc'

  autotools_configure_options '--disable-maintainer-mode \
      --disable-docs \
      --enable-all-static'
end
