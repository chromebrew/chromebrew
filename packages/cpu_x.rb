require 'package'

class Cpu_x < Package
  description 'CPU-X is a Free software that gathers information on CPU, motherboard and more.'
  homepage 'https://x0rg.github.io/CPU-X/'
  version '4.2.0'
  license 'GPL-3'
  compatibility 'x86_64'
  source_url 'https://github.com/X0rg/CPU-X/releases/download/v4.2.0/CPU-X-v4.2.0-x86_64.AppImage'
  source_sha256 '5502ae7df1ac02c79c99f202f866837dd9183ed85f61fe3774eb0887a45a2f3a'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.build
    @cpu = <<~EOF
    #!/bin/bash
    cd #{CREW_PREFIX}/share/cpu-x
    ./AppRun "$@"
    EOF
    IO.write('cpu-x.sh', @cpu)
  end

  def self.install
    prev = ENV['CREW_NOT_STRIP']
    ENV['CREW_NOT_STRIP'] = '1'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/cpu-x"
    FileUtils.install 'cpu-x.sh', "#{CREW_DEST_PREFIX}/bin/cpu-x", mode: 0755
    FileUtils.mv Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/cpu-x"
    ENV['CREW_NOT_STRIP'] = prev
  end

  def self.postinstall
    puts "\nType 'cpu-x' to get started.\n".lightblue
  end
end
