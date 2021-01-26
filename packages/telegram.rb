require 'package'

class Telegram < Package
  description "Telegram is a messaging app with a focus on speed and security, it's super-fast, simple and free."
  homepage 'https://telegram.org/'
  version '2.5.1'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url 'https://updates.tdesktop.com/tlinux/tsetup.2.5.1.tar.xz'
    source_sha256 '939275a84498dedb1a33ac3f0242b0211548ddb087f9801518db92c5d6dc0151'
  end

  def self.build
    system "cat <<'EOF'> telegram
#!/bin/bash
QT_QPA_PLATFORM=wayland-egl DISPLAY= WAYLAND_DISPLAY=wayland-0 Telegram \"\$@\"
EOF"
  end

  def self.install
    FileUtils.install 'Telegram', "#{CREW_DEST_PREFIX}/bin/Telegram", mode: 0755
    FileUtils.install 'telegram', "#{CREW_DEST_PREFIX}/bin/telegram", mode: 0755
  end

  def self.postinstall
    puts
    puts "Type 'telegram' to get started.".lightblue
    puts
  end
end
