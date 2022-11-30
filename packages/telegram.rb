require 'package'

class Telegram < Package
  description "Telegram is a messaging app with a focus on speed and security, it's super-fast, simple and free."
  homepage 'https://telegram.org/'
  version '4.3.1'
  license 'BSD, LGPL-2+ and GPL-3-with-openssl-exception'
  compatibility 'x86_64'
  source_url 'https://github.com/telegramdesktop/tdesktop/releases/download/v4.3.1/tsetup.4.3.1.tar.xz'
  source_sha256 '417d9eae3a6764d7ebe4b1763fdc0d66e0d9a70615b0133cd6628df77da0b2e0'

  depends_on 'mesa'

  no_compile_needed

  def self.build
    telegram = <<~EOF
      #!/bin/bash
      QT_QPA_PLATFORM=wayland-egl DISPLAY= WAYLAND_DISPLAY=wayland-0 Telegram "$@"
    EOF
    File.write('telegram', telegram)
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
