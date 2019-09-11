ENV["CREW_NOT_STRIP"] = "true"

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
  version '1.8.9'
  source_url "https://github.com/arduino/Arduino/releases/download/#{@version}/arduino-#{@version}.tar.xz"
  source_sha256 '49e9c3a3a04c8dae8c2ffbfd39cf83b77d4908a09e29c2b3bfa4697c59ea1bf2'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'xzutils'
  depends_on 'jdk8'
  depends_on 'ant' => :build
  depends_on 'sommelier'

  def self.build
    Dir.chdir("build") do
      system "env",
             "JAVA_HOME=#{CREW_PREFIX}/share/jdk8",
             "ant",
             "-Djava.net.preferIPv4Stack=true",
             "-Dversion=#{@version}",
             "-Dplatform=#{@platform}",
             "clean",
             "dist"
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
      system "tar", "xpf", "linux/arduino-#{@version}-#{@platform}.tar.xz", "-C", "#{CREW_DEST_PREFIX}/share/"
      system "install", "-Dm755", "arduino", "#{CREW_DEST_PREFIX}/bin/arduino"
      system "ln", "-s", "../share/arduino-#{@version}/arduino-builder", "#{CREW_DEST_PREFIX}/bin"
    end
  end
end

ENV["CREW_NOT_STRIP"] = ""
