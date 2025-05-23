require 'buildsystems/autotools'

class Jq < Autotools
  description 'jq is a lightweight and flexible command-line JSON processor.'
  homepage 'https://stedolan.github.io/jq/'
  version '1.7.1'
  license 'MIT and CC-BY-3.0'
  compatibility 'all'
  source_url 'https://github.com/stedolan/jq.git'
  git_hashtag "jq-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '19a92ca161e622c94355fe96936d3f9987a6487c06969fb94ef72085ec87e744',
     armv7l: '19a92ca161e622c94355fe96936d3f9987a6487c06969fb94ef72085ec87e744',
       i686: 'e2b7fe0a8c1c75f6fdf08ea2175109dbdb050226f37cf69001ad85c7b9dbaddf',
     x86_64: 'd4642b7ef212ab8cb60ada93de8eb290c673dc2a6ed636753bd1a1cd6124afbc'
  })

  depends_on 'glibc'

  autotools_configure_options '--disable-maintainer-mode \
      --disable-docs'
end
