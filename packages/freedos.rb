require 'package'

class Freedos < Package
  description 'FreeDOS is a free DOS-compatible operating system.'
  homepage 'http://www.freedos.org/'
  version '1.2'
  compatibility 'all'
  source_url 'http://downloads.sourceforge.net/project/freedos/Kernel/2042/ke2042_86f32.zip'
  source_sha256 '460a6be669a24223e0b0ff7a92502624eb45d1271a535f345b24d5562b29b467'

  depends_on 'libjpeg'
  depends_on 'wayland_protocols'
  depends_on 'hicolor_icon_theme'
  depends_on 'gtk3'
  depends_on 'qemu'

  def self.build
    mb = nil
    loop do
      puts 'Enter the drive C: partition size (in MB):'
      mb = STDIN.gets.chomp.to_i
      break unless mb < 100
      puts 'Enter a number greater than or equal to 100.'
    end

    # See https://opensource.com/article/17/10/run-dos-applications-linux.
    system "mkdir -p $HOME/dosfiles"
    system "mkdir -p #{CREW_DEST_DIR}$HOME/dosfiles"
    system 'wget https://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.2/FD12CD.iso'
    abort 'Checksum mismatch. :/  Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('FD12CD.iso') ) == '6c7f6aad72ab16c592e879367d1ed463047e3b7c94e1828e1ddadb680d461bc3'
    system "qemu-img create freedos.img #{mb}M"
    system "qemu-system-i386 -m 16 -k en-us -rtc base=localtime -soundhw all -device cirrus-vga -display gtk -hda freedos.img -cdrom FD12CD.iso -boot order=d"
    system "echo '#!/bin/bash' > freedos"
    system "echo 'qemu-system-i386 -m 16 -k en-us -rtc base=localtime -soundhw all -device cirrus-vga -display gtk -hda $HOME/freedos.img -drive file=fat:rw:$HOME/dosfiles/ -boot order=c' >> freedos"
  end

  def self.install
    system "install -Dm755 freedos #{CREW_DEST_PREFIX}/bin/freedos"
    system "install -Dm644 freedos.img #{CREW_DEST_PREFIX}$HOME/freedos.img"
    system "install -Dm644 freedos.img $HOME/freedos.img"
  end

  def self.postinstall
    puts
    puts "Type 'freedos' to start.".lightblue
    puts
    puts "Add files to $HOME/dosfiles.".lightblue
    puts
  end
end
