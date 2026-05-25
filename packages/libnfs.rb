require 'buildsystems/autotools'

class Libnfs < Autotools
  description 'client library for accessing NFS shares'
  homepage 'https://github.com/sahlberg/libnfs'
  version '6.0.2'
  compatibility 'all'
  license 'GPL-3, LGPL-2.1 and BSD'
  source_url 'https://github.com/sahlberg/libnfs.git'
  git_hashtag "libnfs-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '93c8332ed7a11e62196a451206a1bb01f5c8d1bba0c860fdf08a6ee52638748f',
     armv7l: '93c8332ed7a11e62196a451206a1bb01f5c8d1bba0c860fdf08a6ee52638748f',
       i686: 'd838e8f83938d1621884496bcc226b33c61b5d20a1c45496d98733cde4c2505c',
     x86_64: '8ff8bdbe19ee2c2bafe7ca410729eb30fc1195de1c3cab48867375752ad59299'
  })

  depends_on 'krb5' => :library
  depends_on 'glibc' => :library

  autotools_configure_options '--enable-utils'
  autotools_pre_configure_options "#{'CFLAGS="$CFLAGS -Wno-cast-align"' if ARCH.include?('armv7l')}"
end
