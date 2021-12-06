require 'package'

class Libxcb < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.14-3'
  license 'custom'
  compatibility 'all'
  source_url 'https://xcb.freedesktop.org/dist/libxcb-1.14.tar.xz'
  source_sha256 'a55ed6db98d43469801262d81dc2572ed124edc3db31059d4e9916eb9f844c34'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxcb/1.14-3_i686/libxcb-1.14-3-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxcb/1.14-3_x86_64/libxcb-1.14-3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    i686: '0a3160d9de6c1b78144f7d04bd73a731e97e04400ede6dc49a5fbe7e4017509c',
  x86_64: '452b493ca96298f6f8c7a9e79503ea99968090223d86ddb5872ac458b23e7e62'
  })

  depends_on 'xcb_proto'
  depends_on 'libxau'
  depends_on 'pthread_stubs'

  def self.build
    system 'filefix'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
        --enable-dri3 \
        --disable-xevie \
        --disable-devel-docs"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
