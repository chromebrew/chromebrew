require 'package'

class Opera < Package
  description 'Opera is a multi-platform web browser based on Chromium and developed by Opera Software.'
  homepage 'https://www.opera.com/'
  version '120.0.5543.161'
  license 'OPERA-2018'
  compatibility 'x86_64'

  source_url "https://deb.opera.com/opera-stable/pool/non-free/o/opera-stable/opera-stable_#{@version}_amd64.deb"
  source_sha256 '37b910edaf3580e5a30efc62d85303909e1fdaf73aaf78574b10e43b04d98060'

  no_compile_needed
  no_shrink

  depends_on 'gtk3'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'harfbuzz'
  depends_on 'graphite'
  depends_on 'cras'
  depends_on 'libcom_err'

  def self.build
    File.write 'opera.sh', <<~EOF
      #!/bin/bash
      LD_LIBRARY_PATH=/usr/local/share/x86_64-linux-gnu/opera:$LD_LIBRARY
      #{CREW_PREFIX}/share/x86_64-linux-gnu/opera/opera "$@"
    EOF
  end

  def self.install
    # Since opera puts the executable in a location that is not in the path,
    # we need to link it to bin directory.
    # FileUtils.ln_sf "#{CREW_PREFIX}/share/x86_64-linux-gnu/opera/opera", 'bin/opera'

    # Move lib subfolder to the share directory.
    FileUtils.mv 'lib/x86_64-linux-gnu/', 'share/'
    FileUtils.rm_rf %w[bin/ lib/]
    FileUtils.install 'opera.sh', "#{CREW_DEST_PREFIX}/bin/opera", mode: 0o755
    FileUtils.rm_f 'opera.sh'

    FileUtils.mv Dir['*'], CREW_DEST_PREFIX
  end

  def self.postinstall
    ConvenienceFunctions.set_default_browser('Opera', 'opera')
  end

  def self.preremove
    ConvenienceFunctions.unset_default_browser('x86_64-linux-gnu/opera', 'opera')
  end
end
