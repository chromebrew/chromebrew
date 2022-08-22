require 'package'

class Putty < Package
  description 'Free Telnet, SSH, and Rlogin clients plus a terminal emulator'
  homepage 'https://www.chiark.greenend.org.uk/~sgtatham/putty/'
  version '0.76'
  license 'MIT'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://the.earth.li/~sgtatham/putty/latest/putty-0.76.tar.gz'
  source_sha256 '547cd97a8daa87ef71037fab0773bceb54a8abccb2f825a49ef8eba5e045713f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/putty/0.76_armv7l/putty-0.76-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/putty/0.76_armv7l/putty-0.76-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/putty/0.76_x86_64/putty-0.76-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1c8444fbab905ffbe099078db6165da8056a1f4cfcd7ad038bcd9bd0a00c4d2c',
     armv7l: '1c8444fbab905ffbe099078db6165da8056a1f4cfcd7ad038bcd9bd0a00c4d2c',
     x86_64: '6c0e2c9e868099bdcd4657a380b269e1ee97fc10020cce67cacf32a5b0616a37'
  })

  depends_on 'gtk3'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
