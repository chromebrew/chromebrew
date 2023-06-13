require 'package'

class Cpu_x < Package
  description 'CPU-X is a Free software that gathers information on CPU, motherboard and more.'
  homepage 'https://x0rg.github.io/CPU-X/'
  version '4.3.0'
  license 'GPL-3'
  compatibility 'x86_64'
  source_url 'https://github.com/X0rg/CPU-X/releases/download/v4.3.0/CPU-X-v4.3.0-x86_64.AppImage'
  source_sha256 '119cc4207d1548a866664077f9f8535659f045b9708a3c6e2b2db973ec1ea2bc'

  no_compile_needed

  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.build
    @cpu = <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/cpu-x
      ./AppRun "$@"
    EOF
    File.write('cpu-x.sh', @cpu)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/cpu-x"
    FileUtils.install 'cpu-x.sh', "#{CREW_DEST_PREFIX}/bin/cpu-x", mode: 0o755
    FileUtils.mv '*', "#{CREW_DEST_PREFIX}/share/cpu-x"
  end

  def self.postinstall
    puts "\nType 'cpu-x' to get started.\n".lightblue
  end
end
