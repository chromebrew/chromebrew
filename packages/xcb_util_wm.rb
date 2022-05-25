require 'package'

class Xcb_util_wm < Package
  description 'The xcb-util-wm package contains libraries which provide client and window-manager helpers for EWMH and ICCCM.'
  homepage 'http://xcb.freedesktop.org'
  version '0.4.1-1'
  compatibility 'all'
  license 'MIT-with-advertising'
  source_url 'https://xcb.freedesktop.org/dist/xcb-util-wm-0.4.1.tar.bz2'
  source_sha256 '28bf8179640eaa89276d2b0f1ce4285103d136be6c98262b6151aaee1d3c2a3f'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_util_wm/0.4.1-1_armv7l/xcb_util_wm-0.4.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_util_wm/0.4.1-1_armv7l/xcb_util_wm-0.4.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_util_wm/0.4.1-1_i686/xcb_util_wm-0.4.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_util_wm/0.4.1-1_x86_64/xcb_util_wm-0.4.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '860d613c9e5ddb61f6cc91f1a12a3c31733e7c489de988b904708ae557e092d5',
     armv7l: '860d613c9e5ddb61f6cc91f1a12a3c31733e7c489de988b904708ae557e092d5',
       i686: 'c30f8f2da2d2493e53929556390ef1e140ac53e6e785c30a1ecc7adb4c26dfb6',
     x86_64: '2db848479b901c4a9cdb59723ad1f96c549707c9edd7975c1620bf1e96307615'
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
