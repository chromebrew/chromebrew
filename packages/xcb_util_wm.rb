require 'package'

class Xcb_util_wm < Package
  description 'The xcb-util-wm package contains libraries which provide client and window-manager helpers for EWMH and ICCCM.'
  homepage 'http://xcb.freedesktop.org'
  version '0.4.1'
  source_url 'https://xcb.freedesktop.org/dist/xcb-util-wm-0.4.1.tar.bz2'
  source_sha256 '28bf8179640eaa89276d2b0f1ce4285103d136be6c98262b6151aaee1d3c2a3f'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libxcb'
  depends_on 'm4'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
