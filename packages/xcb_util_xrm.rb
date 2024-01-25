require 'package'

class Xcb_util_xrm < Package
  description 'XCB utility functions for the X resource manager'
  homepage 'https://github.com/Airblader/xcb-util-xrm'
  version '1.3-1'
  compatibility 'all'
  license 'MIT-with-advertising'
  source_url 'https://github.com/Airblader/xcb-util-xrm/releases/download/v1.3/xcb-util-xrm-1.3.tar.bz2'
  source_sha256 '301cf33701207ea8782d49f4cb6404abd8f2d64e16f242017fd720be7c900c85'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '70cdd52679ee61272c4f07bcc1bc75132512415004011e67dc844ca26c22e5e6',
     armv7l: '70cdd52679ee61272c4f07bcc1bc75132512415004011e67dc844ca26c22e5e6',
       i686: '85e432baec61c1092613482a57fba8b4e159458680c09e28e3239213b375d579',
     x86_64: 'f0915ed1d530e21c0e75d8807189ce5e4adc7205e4469d47d418e490266ef277'
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
