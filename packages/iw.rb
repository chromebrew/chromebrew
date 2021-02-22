require 'package'

class Iw < Package
  description 'iw is a new nl80211 based CLI configuration utility for wireless devices.'
  homepage 'https://wireless.wiki.kernel.org/en/users/documentation/iw'
  version '5.9'
  compatibility 'all'
  source_url 'https://git.kernel.org/pub/scm/linux/kernel/git/jberg/iw.git/snapshot/iw-5.9.tar.gz'
  source_sha256 'f38a82a9bfa2a45d6bf471fe84df9c39bed3d3ca0e8931ed31951f603e21deb3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/iw-5.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/iw-5.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/iw-5.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/iw-5.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4f922f68dfda3cba18a781f9210a2558bcefd57b4a2392ac20c4390761faab02',
     armv7l: '4f922f68dfda3cba18a781f9210a2558bcefd57b4a2392ac20c4390761faab02',
       i686: 'e20c4d140d008308e5d04126f3bf747ab46a5d4b908aa44a1cd926088a28d2db',
     x86_64: '6d6c34ef075e62e2adaff8122f21737e1411141be997c4bc90bab316a41c4be3',
  })

  depends_on 'libnl3'

  def self.patch
    system "sed -i 's:/usr:#{CREW_PREFIX}:g' Makefile" # Change prefix to CREW_PREFIX
  end

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
