require 'package'

class Arduino_ide < Package
  description 'Arduino is an open-source physical computing platform based on a simple I/O board and a development environment that implements the Processing/Wiring language.'
  homepage 'https://www.arduino.cc/'
  version '2.3.11'
  license 'GPL-2, LGPL-2.1 and CC-BY-SA-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.arduino.cc/arduino-ide/arduino-ide_#{version}_Linux_64bit.zip"
  source_sha256 '1e009f3c720092e6fae4e71809e0b755058e8c5d59eac7548b288d4f42b5e9b1'

  depends_on 'openjdk17'
  depends_on 'sommelier' => :logical
  depends_on 'xzutils'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/arduino-ide"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/arduino-ide"
    FileUtils.ln_s "#{CREW_PREFIX}/share/arduino-ide/arduino-ide", "#{CREW_DEST_PREFIX}/bin/arduino-ide"
  end

  def self.postinstall
    ExitMessage.add "\nType 'arduino-ide' to launch.\n"
  end
end
