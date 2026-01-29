require 'package'

class Balena_etcher < Package
  description 'Flash OS images to SD cards & USB drives, safely and easily.'
  homepage 'https://etcher.balena.io'
  version '2.1.4'
  license 'Apache-2.0'
  compatibility 'x86_64'
  min_glibc '2.33'
  source_url "https://github.com/balena-io/etcher/releases/download/v#{version}/balenaEtcher-linux-x64-#{version}.zip"
  source_sha256 'b0e08f001cc15cb0d648832db1d23273aa6ff25111bc104b8bc1f794aa9616d9'

  depends_on 'gtk3'
  depends_on 'freetype'
  depends_on 'cairo'
  depends_on 'xzutils'
  depends_on 'libnotify'
  depends_on 'nss'
  depends_on 'libgconf'
  depends_on 'libxss'
  depends_on 'libcom_err'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'unzip'
  depends_on 'xhost'
  depends_on 'sommelier' => :logical

  gnome
  no_compile_needed
  no_shrink

  def self.build
    File.write 'etcher.sh', <<~EOF
      #!/bin/bash
      xhost si:localuser:root
      cd #{CREW_PREFIX}/share/balena-etcher
      sudo -E LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} ./balena-etcher --no-sandbox "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/bin #{CREW_DEST_PREFIX}/share/balena-etcher]
    FileUtils.install 'etcher.sh', "#{CREW_DEST_PREFIX}/bin/etcher", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/balena-etcher"
  end

  def self.postinstall
    ExitMessage.add "\nType 'etcher' to get started.\n"
  end
end
