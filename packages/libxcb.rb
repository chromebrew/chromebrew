require 'package'

class Libxcb < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.14-2'
  compatibility 'all'
  source_url 'https://xcb.freedesktop.org/dist/libxcb-1.14.tar.xz'
  source_sha256 'a55ed6db98d43469801262d81dc2572ed124edc3db31059d4e9916eb9f844c34'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxcb-1.14-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxcb-1.14-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxcb-1.14-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxcb-1.14-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '970a54ee26b5719351236de38fa8e714815f478fb76a53b07ed8458950f0e7e8',
     armv7l: '970a54ee26b5719351236de38fa8e714815f478fb76a53b07ed8458950f0e7e8',
       i686: '95447782172b761f15c728f2a5d0d99e7e34987ba069f0c788e225134e72eee9',
     x86_64: 'b3d0f1ae99ab39ada872217c14bf137e7f77ff1f37c357408c649e19a152ec53'
  })

  depends_on 'xcb_proto'
  depends_on 'libxau'
  depends_on 'pthread_stubs'

  def self.build
    system 'filefix'
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' \
        LDFLAGS='-flto=auto' \
        ./configure #{CREW_OPTIONS} \
        --enable-dri3 \
        --disable-xevie \
        --disable-devel-docs"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
