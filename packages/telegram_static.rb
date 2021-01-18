require 'package'

class Telegram_static < Package
  description 'Telegram is a cloud-based mobile and desktop messaging app with a focus on security and speed. (official static version from https://desktop.telegram.org)'
  homepage 'https://telegram.org'
  version '2.5.1'
  compatibility 'x86_64, i686'
  
  depends_on 'sommelier'

  case ARCH
  when 'x86_64'
    source_url 'https://updates.tdesktop.com/tlinux/tsetup.2.5.1.tar.xz'
    source_sha256 '939275a84498dedb1a33ac3f0242b0211548ddb087f9801518db92c5d6dc0151'
  when 'i686'
    source_url 'https://updates.tdesktop.com/tlinux32/tsetup32.2.4.4.tar.xz'
    source_sha256 '0779c5d46218ec53dc3caf450093c7537e40c06c876da77270c57667e5df6589'
  end

  depends_on 'sommelier'

  def self.install
    system "mkdir #{CREW_DEST_PREFIX}/bin -p"
    system "mv Telegram #{CREW_DEST_PREFIX}/bin/telegram-static"
  end
end
