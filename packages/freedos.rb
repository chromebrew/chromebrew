require 'package'

class Freedos < Package
  description 'FreeDOS is a free DOS-compatible operating system.'
  homepage 'https://www.freedos.org/'
  version '1.2'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://downloads.sourceforge.net/project/freedos/Kernel/2042/ke2042_86f32.zip'
  source_sha256 '460a6be669a24223e0b0ff7a92502624eb45d1271a535f345b24d5562b29b467'

  depends_on 'libjpeg_turbo'
  depends_on 'wayland_protocols'
  depends_on 'hicolor_icon_theme'
  depends_on 'gtk3'
  depends_on 'qemu'

  def self.build
    mb = nil
    loop do
      puts 'Enter the drive C: partition size (in MB):'
      mb = $stdin.gets.chomp.to_i
      break unless mb < 100

      puts 'Enter a number greater than or equal to 100.'
    end

    # See https://opensource.com/article/17/10/run-dos-applications-linux.
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/dosfiles"
    downloader 'https://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.2/FD12CD.iso', '6c7f6aad72ab16c592e879367d1ed463047e3b7c94e1828e1ddadb680d461bc3'
    system "qemu-img create freedos.img #{mb}M"
    system 'qemu-system-i386 -m 16 -k en-us -rtc base=localtime -soundhw all -device cirrus-vga -display gtk -hda freedos.img -cdrom FD12CD.iso -boot order=d'
    system "echo '#!/bin/bash' > freedos"
    system "echo 'qemu-system-i386 -m 16 -k en-us -rtc base=localtime -soundhw all -device cirrus-vga -display gtk -hda $HOME/freedos.img -drive file=fat:rw:$HOME/dosfiles/ -boot order=c' >> freedos"
  end

  def self.install
    FileUtils.install 'freedos', "#{CREW_DEST_PREFIX}/bin/freedos", mode: 0o755
    FileUtils.install 'freedos.img', "#{CREW_DEST_HOME}/freedos.img", mode: 0o644
  end

  def self.postinstall
    puts
    puts "Type 'freedos' to start.".lightblue
    puts
    puts "Add files to #{HOME}/dosfiles.".lightblue
    puts
  end
end
