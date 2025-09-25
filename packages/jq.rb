require 'buildsystems/autotools'

class Jq < Autotools
  description 'jq is a lightweight and flexible command-line JSON processor.'
  homepage 'https://stedolan.github.io/jq/'
  version '1.8.1'
  license 'MIT and CC-BY-3.0'
  compatibility 'all'
  source_url 'https://github.com/stedolan/jq.git'
  git_hashtag "jq-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9b43ad5b36f03354c8617508dba0b1cb0e22c917502a65e562ec57b08f63e5ea',
     armv7l: '9b43ad5b36f03354c8617508dba0b1cb0e22c917502a65e562ec57b08f63e5ea',
       i686: '3890e4b752480f64c8a424801ab6069b4c78db456bdeb1d42ea97bc930e260da',
     x86_64: '1c10b89e6e12e52466f1b4dabe999ba9d705c54bddc2b3258e13898103f83826'
  })

  depends_on 'glibc' # R
  depends_on 'oniguruma' # R

  autotools_configure_options "--disable-maintainer-mode \
      --disable-docs \
      --enable-static#{'=no' if ARCH == 'i686'}"
end
