ENV['CREW_NOT_STRIP'] = 'true'

require 'package'

class Arduino_ide < Package

  @version = "1.8.9"

  case ARCH
  when 'x86_64'
    @platform = 'linux64'
  when 'i686'
    @platform = 'linux32'
  when 'armv7l', 'aarch64'
    @platform = 'linuxarm'
  end

  description 'Arduino is an open-source physical computing platform based on a simple I/O board and a development environment that implements the Processing/Wiring language.'
  homepage 'https://www.arduino.cc/'
  version '1.8.10'
  compatibility 'all'
  source_url 'https://github.com/arduino/Arduino/releases/download/1.8.10/arduino-1.8.10.tar.xz'
  source_sha256 '862e4b100d5214ca51d501edcc095467d7a4e3dc39b306146001da8b0c63343e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/arduino_ide-1.8.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/arduino_ide-1.8.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/arduino_ide-1.8.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/arduino_ide-1.8.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cf323df5db4b7b3d225199539f185cdd66bb7d86705b8eec5125d1538508bf9b',
     armv7l: 'cf323df5db4b7b3d225199539f185cdd66bb7d86705b8eec5125d1538508bf9b',
       i686: '9755e405993c3608fa7ff631eab47b0ab25af9b043f369ebf96d512e4a0b0375',
     x86_64: 'f3a6d2ae75065565c1891d09b4e5556647be4dd6e5a04d8345b5a3b0d1183792',
  })

  depends_on 'xzutils'
  depends_on 'jdk8'
  depends_on 'ant' => :build
  depends_on 'sommelier'

  def self.build
    Dir.chdir("build") do
      system 'env',
             "JAVA_HOME=#{CREW_PREFIX}/share/jdk8",
             'ant',
             '-Djava.net.preferIPv4Stack=true',
             "-Dversion=#{@version}",
             "-Dplatform=#{@platform}",
             'clean',
             'dist'
      system "echo '#!/bin/bash' > arduino"
      system "echo >> arduino"
      system "echo 'echo \"Enabling Arduino write access...\"' >> arduino"
      system "echo 'sudo chmod o+rw /dev/ttyACM*' >> arduino"
      system "echo '#{CREW_PREFIX}/share/arduino-#{@version}/arduino \"$@\"' >> arduino"
      system "echo 'echo \"Disabling Arduino write access...\"' >> arduino"
      system "echo 'sudo chmod o-rw /dev/ttyACM*' >> arduino"
    end
  end

  def self.install
    Dir.chdir("build") do
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
      system "tar xpf linux/arduino-#{@version}-#{@platform}.tar.xz -C #{CREW_DEST_PREFIX}/share/"
      system "install -Dm755 arduino #{CREW_DEST_PREFIX}/bin/arduino"
      FileUtils.ln_s "../share/arduino-#{@version}/arduino-builder", "#{CREW_DEST_PREFIX}/bin"
    end
  end
end

ENV['CREW_NOT_STRIP'] = ''
