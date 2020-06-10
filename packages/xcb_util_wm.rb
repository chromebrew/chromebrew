require 'package'

class Xcb_util_wm < Package
  description 'The xcb-util-wm package contains libraries which provide client and window-manager helpers for EWMH and ICCCM.'
  homepage 'http://xcb.freedesktop.org'
  version '0.4.1'
  compatibility 'all'
  source_url 'https://xcb.freedesktop.org/dist/xcb-util-wm-0.4.1.tar.bz2'
  source_sha256 '28bf8179640eaa89276d2b0f1ce4285103d136be6c98262b6151aaee1d3c2a3f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_wm-0.4.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_wm-0.4.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_wm-0.4.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_wm-0.4.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'eca2ea7322b69ffa1ffc26b2c9e8b27b3f497a903245096ab5714058d9cbcb6c',
     armv7l: 'eca2ea7322b69ffa1ffc26b2c9e8b27b3f497a903245096ab5714058d9cbcb6c',
       i686: 'fa02ea38391ab60dd57b1fba349d264d35275b460326ea717f080657d11e8af3',
     x86_64: '076d76e8706ea6e25545f3878f06f481584066f57bbaea0be00964358ec38be5',
  })

  depends_on 'libxcb'
  depends_on 'm4'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
