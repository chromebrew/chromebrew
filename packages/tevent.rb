# Adapted from Arch Linux tevent PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/tevent/trunk/PKGBUILD

require 'package'

class Tevent < Package
  description 'Event system based on the talloc memory management library'
  homepage 'https://tevent.samba.org/'
  @_ver = '0.15.0'
  version "#{@_ver}-py3.12"
  license 'LGPL'
  compatibility 'all'
  source_url "https://samba.org/ftp/tevent/tevent-#{@_ver}.tar.gz"
  source_sha256 '662a9f277281bcf506b6bc0a0baa03e44a62229516ee34bcc703a0b82aa46905'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tevent/0.15.0-py3.12_armv7l/tevent-0.15.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tevent/0.15.0-py3.12_armv7l/tevent-0.15.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tevent/0.15.0-py3.12_i686/tevent-0.15.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tevent/0.15.0-py3.12_x86_64/tevent-0.15.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4c53a7e86a60c982855809c9bca2cbaf4802b1cc8d7919fae6b71e3e4d6deaa7',
     armv7l: '4c53a7e86a60c982855809c9bca2cbaf4802b1cc8d7919fae6b71e3e4d6deaa7',
       i686: '9f0ed4a472cbb1acdb356bf23b9354cb5f22a9a66cf91be6669808fb3acff081',
     x86_64: 'fe16ba3edd13137222598a9565f4f3ae6e231b80868bdfcc262805c84183b412'
  })

  depends_on 'cmocka' => :build
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libxcrypt' => :build
  depends_on 'python3' => :build
  depends_on 'talloc' # R

  def self.build
    system "./configure #{CREW_OPTIONS.sub(/--program-suffix.*/, '')} \
      --sysconfdir=#{CREW_PREFIX}/etc/samba \
      --localstatedir=#{CREW_PREFIX}/var \
      --bundled-libraries=NONE \
      --builtin-libraries=replace"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
