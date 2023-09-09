require 'package'

class Balena_etcher < Package
  description 'Flash OS images to SD cards & USB drives, safely and easily.'
  homepage 'https://www.balena.io/etcher/'
  version '1.18.12'
  license 'Apache-2.0'
  compatibility 'x86_64'

  source_url({
    x86_64: "https://github.com/balena-io/etcher/releases/download/v#{version}/balenaEtcher-#{version}-x64.AppImage"
  })

  source_sha256({
    x86_64: 'eba1a7439a71ae65d97089b4f64373b501934b55d7df4b8d2fb07bb5495b785b'
  })

  depends_on 'gtk3'
  depends_on 'freetype'
  depends_on 'cairo'
  depends_on 'xzutils'
  depends_on 'libnotify'
  depends_on 'nspr'
  depends_on 'libgconf'
  depends_on 'libxss'
  depends_on 'libcom_err'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'xhost'
  depends_on 'sommelier'

  no_compile_needed
  no_shrink

  def self.build
    @etcher = <<~EOF
      #!/bin/bash
      xhost si:localuser:root
      cd #{CREW_PREFIX}/share/balena-etcher
      sudo -E LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} ./AppRun "$@"
    EOF
    File.write('etcher.sh', @etcher)
  end

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/bin #{CREW_DEST_PREFIX}/share/balena-etcher]
    FileUtils.install 'etcher.sh', "#{CREW_DEST_PREFIX}/bin/etcher", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/balena-etcher"
  end

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
    puts
    puts "To get started, type 'etcher'.".lightblue
    puts
  end
end
