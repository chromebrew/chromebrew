require 'package'
require 'convenience_functions'

class Opera < Package
  description 'Opera is a multi-platform web browser based on Chromium and developed by Opera Software.'
  homepage 'https://www.opera.com/'
  version '118.0.5461.104'
  license 'OPERA-2018'
  compatibility 'x86_64'
  min_glibc '2.29'

  # faster apt mirror, but only works when downloading latest version of opera
  # source_url "https://deb.opera.com/opera/pool/non-free/o/opera-stable/opera-stable_#{version}_amd64.deb"
  source_url "https://deb.opera.com/opera-stable/pool/non-free/o/opera-stable/opera-stable_#{version}_amd64.deb"
  source_sha256 '8417acee76c7c2ea848078589e8f22b71af117f4e74ab6664980278ea7e6832c'

  depends_on 'gtk3'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'harfbuzz'
  depends_on 'graphite'
  depends_on 'cras'
  depends_on 'libcom_err'

  no_compile_needed
  no_shrink

  def self.install
    # Since opera puts the executable in a location that is not in the path,
    # we need to link it to bin directory.
    FileUtils.ln_sf "#{CREW_PREFIX}/share/x86_64-linux-gnu/opera/opera", 'bin/opera'

    # Move lib subfolder to the share directory.
    FileUtils.mv 'lib/x86_64-linux-gnu/', 'share/'
    FileUtils.rm_rf 'lib/'

    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv Dir['*'], CREW_DEST_PREFIX
  end

  def self.postinstall
    ConvenienceFunctions.set_default_browser('Opera', 'opera')
  end

  def self.preremove
    ConvenienceFunctions.unset_default_browser('x86_64-linux-gnu/opera', 'opera')
  end
end
