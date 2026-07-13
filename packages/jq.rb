require 'buildsystems/autotools'

class Jq < Autotools
  description 'jq is a lightweight and flexible command-line JSON processor.'
  homepage 'https://stedolan.github.io/jq/'
  version '1.8.2'
  license 'MIT and CC-BY-3.0'
  compatibility 'all'
  source_url 'https://github.com/stedolan/jq.git'
  git_hashtag "jq-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '12101470f0e6b6dec30e00ace0ad6bce7f63bf4e0e16e37dd9744c160c7172f2',
     armv7l: '12101470f0e6b6dec30e00ace0ad6bce7f63bf4e0e16e37dd9744c160c7172f2',
       i686: 'e5bab74ab5e36374a8f2fc36d18dcd7683b7bb37803b79796683227480beb55c',
     x86_64: 'bdce1a53efe2c8378e0b95d81a445e942d63fb0ebbd1580ac20ad67e73df62df'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'oniguruma' => :library

  autotools_configure_options "--disable-maintainer-mode \
      --disable-docs \
      --enable-static#{'=no' if ARCH == 'i686'}"
end
