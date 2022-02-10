require 'package'

class Telegram < Package
  description "Telegram is a messaging app with a focus on speed and security, it's super-fast, simple and free."
  homepage 'https://telegram.org/'
  version '3.5.2'
  license 'BSD, LGPL-2+ and GPL-3-with-openssl-exception'
  compatibility 'x86_64'
  source_url 'https://github.com/telegramdesktop/tdesktop/releases/download/v3.5.2/tsetup.3.5.2.tar.xz'
  source_sha256 'd31fb3ea38cfddf5808fc60c38b916b977c85d0c5aaa83565cc6554c69d5e572'

  def self.build
    telegram = <<~EOF
    #!/bin/bash
    QT_QPA_PLATFORM=wayland-egl DISPLAY= WAYLAND_DISPLAY=wayland-0 Telegram "$@"
    EOF
    IO.write('telegram', telegram)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'Telegram', "#{CREW_DEST_PREFIX}/bin/Telegram", mode: 0o755
    FileUtils.install 'telegram', "#{CREW_DEST_PREFIX}/bin/telegram", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'telegram' to get started.\n".lightblue
  end
end
