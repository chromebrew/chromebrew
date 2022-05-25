require 'buildsystems/autotools'

class Jq < Autotools
  description 'jq is a lightweight and flexible command-line JSON processor.'
  homepage 'https://stedolan.github.io/jq/'
  @_ver = '1.7'
  version @_ver
  license 'MIT and CC-BY-3.0'
  compatibility 'all'
  source_url 'https://github.com/stedolan/jq.git'
  git_hashtag "jq-#{@_ver}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jq/1.7_armv7l/jq-1.7-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jq/1.7_armv7l/jq-1.7-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jq/1.7_i686/jq-1.7-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jq/1.7_x86_64/jq-1.7-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '15ef868608c85cbac630d00281ffa6b50d3513cb2fa268f19aab9fefdc145c83',
     armv7l: '15ef868608c85cbac630d00281ffa6b50d3513cb2fa268f19aab9fefdc145c83',
       i686: '2fe7d41c40699c57822393b5b3606f43641750e743751db729c153357924ea8e',
     x86_64: '5391d895d83e5c79eca278380ea062dc28478eeaa7afe2d900adcd64bcf7e12d'
  })

  depends_on 'glibc'

  configure_options '--disable-maintainer-mode \
      --disable-docs'
end
