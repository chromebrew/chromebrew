ENV["CREW_NOT_STRIP"] = "true"

require 'package'

class Arduino_ide < Package
  description 'Arduino is an open-source physical computing platform based on a simple I/O board and a development environment that implements the Processing/Wiring language.'
  homepage 'https://www.arduino.cc/'
  version '1.8.7'
  source_url 'https://github.com/arduino/Arduino/releases/download/1.8.7/arduino-1.8.7.tar.xz'
  source_sha256 'f9d684554c7bd55065d9163cc6819acf17dc8826f9ccb27437fb22401b29326e'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'xzutils'
  depends_on 'jdk8'
  depends_on 'ant' => :build
  depends_on 'sommelier'

  def self.build
    case ARCH
    when 'x86_64'
      platform = 'linux64'
    when 'i686'
      platform = 'linux32'
    when 'armv7l', 'aarch64'
      platform = 'linuxarm'
    end
    Dir.chdir("build") do
      system "env",
             "JAVA_HOME=#{CREW_PREFIX}/share/jdk8",
             "ant",
             "-Djava.net.preferIPv4Stack=true",
             "-Dversion=#{version}",
             "-Dplatform=#{platform}",
             "clean",
             "dist"
      system "echo '#!/bin/bash' > arduino"
      system "echo >> arduino"
      system "echo 'echo \"Enabling Arduino write access...\"' >> arduino"
      system "echo 'sudo  chmod o+w /dev/ttyACM*' >> arduino"
      system "echo 'sommelier -X --x-display=\$DISPLAY --scale=\$SCALE #{CREW_PREFIX}/share/arduino-#{version}/arduino \"$@\"' >> arduino"
      system "echo 'echo \"Disabling Arduino write access...\"' >> arduino"
      system "echo 'sudo chmod o-w /dev/ttyACM*' >> arduino"
    end
  end

  def self.install
    case ARCH
    when 'x86_64'
      platform = 'linux64'
    when 'i686'
      platform = 'linux32'
    when 'armv7l', 'aarch64'
      platform = 'linuxarm'
    end
    Dir.chdir("build") do
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
      system "tar", "xpvf", "linux/arduino-#{version}-#{platform}.tar.xz", "-C", "#{CREW_DEST_PREFIX}/share/"
      system "install", "-Dm755", "arduino", "#{CREW_DEST_PREFIX}/bin/arduino"
    end
  end
end

ENV["CREW_NOT_STRIP"] = ""
