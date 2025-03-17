require 'package'

class Upscayl < Package
  description 'Free and Open Source AI Image Upscaler'
  homepage 'https://upscayl.org/'
  version '2.15.0'
  license 'AGPL-3.0'
  compatibility 'x86_64'
  source_url "https://github.com/upscayl/upscayl/releases/download/v#{version}/upscayl-#{version}-linux.AppImage"
  source_sha256 '6459457e589bcb99e779ea442dce608bacda33916b7019a8862b7c6252aa8229'

  depends_on 'gtk3'

  no_compile_needed
  no_shrink

  def self.build
    File.write 'upscayl.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/upscayl
      ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/upscayl"
    FileUtils.install 'upscayl.sh', "#{CREW_DEST_PREFIX}/bin/upscayl", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/upscayl"
  end

  def self.postinstall
    ExitMessage.add "\nType 'upscayl' to get started.\n"
  end
end
