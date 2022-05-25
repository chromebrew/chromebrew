require 'package'

class Arduino_ide < Package
  description 'Arduino is an open-source physical computing platform based on a simple I/O board and a development environment that implements the Processing/Wiring language.'
  homepage 'https://www.arduino.cc/'
  version '1.8.19'
  license 'GPL-2, LGPL-2.1 and CC-BY-SA-3.0'
  compatibility 'all'
  source_url 'https://github.com/arduino/Arduino/releases/download/1.8.19/arduino-1.8.19.tar.xz'
  source_sha256 '350c7e64a38d562c3c5b61e9b93d4d64455a2c71bd0773a5c593198b8efa578d'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/arduino_ide/1.8.19_armv7l/arduino_ide-1.8.19-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/arduino_ide/1.8.19_armv7l/arduino_ide-1.8.19-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/arduino_ide/1.8.19_i686/arduino_ide-1.8.19-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/arduino_ide/1.8.19_x86_64/arduino_ide-1.8.19-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '33bd83f692a6f241b14738bfef32a9118ebb6eb2f4936b69909e2c9f546d49d3',
     armv7l: '33bd83f692a6f241b14738bfef32a9118ebb6eb2f4936b69909e2c9f546d49d3',
       i686: '1636654217841dd03dc22b315228ced30f9c50f67d39b6892f75e0732624dcb3',
     x86_64: 'd48a6cf203c563b343d3c33dd8c2767a8a416446ef73b34ca931ee964e88b244'
  })

  depends_on 'xzutils'
  depends_on 'openjdk8'
  depends_on 'ant' => :build
  depends_on 'sommelier'

  case ARCH
  when 'x86_64'
    @platform = 'linux64'
  when 'i686'
    @platform = 'linux32'
  when 'armv7l', 'aarch64'
    @platform = 'linuxarm'
  end

  def self.build
    ENV['JAVA_HOME'] = CREW_PREFIX
    Dir.chdir 'build' do
      system 'ant',
             '-Djava.net.preferIPv4Stack=true',
             "-Dversion=#{version}",
             "-Dplatform=#{@platform}",
             'clean',
             'dist'
      arduino = <<~EOF
        #!/bin/bash
        echo "Enabling Arduino write access..."
        sudo chmod o+rw /dev/ttyACM*
        #{CREW_PREFIX}/share/arduino-#{version}/arduino "$@"
        echo "Disabling Arduino write access..."
        sudo chmod o-rw /dev/ttyACM*
      EOF
      File.write('arduino', arduino)
    end
  end

  def self.install
    Dir.chdir 'build' do
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
      system "tar xpf linux/arduino-#{version}-#{@platform}.tar.xz -C #{CREW_DEST_PREFIX}/share/"
      FileUtils.install 'arduino', "#{CREW_DEST_PREFIX}/bin/arduino", mode: 0o755
      FileUtils.ln_s "../share/arduino-#{version}/arduino-builder", "#{CREW_DEST_PREFIX}/bin"
    end
  end
end
