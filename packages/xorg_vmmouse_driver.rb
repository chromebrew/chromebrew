require 'package'

class Xorg_vmmouse_driver < Package
  description 'The Xorg VMMouse Driver package contains the VMMouse input driver for the Xorg X server. The VMMouse driver enables support for the special VMMouse protocol that is provided by VMware virtual machines to give absolute pointer positioning.'
  homepage 'https://www.x.org'
  version '13.1.0'
  license 'MIT-with-advertising and ISC'
  compatibility 'i686,x86_64'
  source_url 'https://www.x.org/pub/individual/driver/xf86-input-vmmouse-13.1.0.tar.bz2'
  source_sha256 '0af558957ac1be1b2863712c2475de8f4d7f14921fd01ded2e2fde4921b19319'
  binary_compression 'tar.xz'

  depends_on 'xorg_server' => :build

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_vmmouse_driver/13.1.0_i686/xorg_vmmouse_driver-13.1.0-chromeos-i686.tar.xz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_vmmouse_driver/13.1.0_x86_64/xorg_vmmouse_driver-13.1.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    i686: 'd24b37d653b0c8a57373f10b8431ad26691a196f0d9d9e5ba45495c65b9a60eb',
    x86_64: '5a2837b20f71f04a5d5791adf96c5c78795e1a8487ee564795779e7c91fb9a01'
  })

  # Only for x86 architecture

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-shared',
           '--disable-static'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-strip'
  end
end
