require 'package'

class Cpu_x < Package
  description 'CPU-X is a Free software that gathers information on CPU, motherboard and more.'
  homepage 'https://thetumultuousunicornofdarkness.github.io/CPU-X/'
  version '5.0.4'
  license 'GPL-3'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url 'https://github.com/TheTumultuousUnicornOfDarkness/CPU-X/releases/download/v5.0.4/CPU-X-5.0.4-x86_64.AppImage'
  source_sha256 '40894470a38c86011e607c5db8492ca9a7906daf7e3c7e6ba7f873c7acc8f777'

  no_compile_needed

  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.build
    File.write 'cpu-x.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/cpu-x
      ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/cpu-x"
    FileUtils.install 'cpu-x.sh', "#{CREW_DEST_PREFIX}/bin/cpu-x", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/cpu-x"
  end

  def self.postinstall
    ExitMessage.add "\nType 'cpu-x' to get started.\n".lightblue
  end
end
