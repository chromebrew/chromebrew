require 'package'

class Unsloth < Package
  description 'Local UI to run and train LLMs and diffusion models'
  homepage 'https://unsloth.ai/'
  version '0.1.904-beta'
  license 'Apache-2.0, AGPL-3.0'
  compatibility 'x86_64'
  min_glibc '2.30'
  source_url "https://github.com/unslothai/unsloth/releases/download/v#{version}/Unsloth-Desktop-Linux.AppImage"
  source_sha256 'd760db709f3ea6f006159a3c192b1f7789aff4f5d36983d8e7288ca4ab2f3aa2'

  no_compile_needed
  no_shrink

  depends_on 'gtk3'
  depends_on 'sommelier' => :logical

  def self.build
    File.write 'unsloth.sh', <<~EOF
      #!/bin/bash
      export LD_LIBRARY_PATH=#{CREW_PREFIX}/share/unsloth/usr/lib
      cd #{CREW_PREFIX}/share/unsloth
      GDK_BACKEND=x11 ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/unsloth"
    FileUtils.install 'unsloth.sh', "#{CREW_DEST_PREFIX}/bin/unsloth", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/unsloth"
  end

  def self.postinstall
    ExitMessage.add "\nType 'unsloth' to get started.\n"
  end
end
