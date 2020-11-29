require 'package'

class Shotcut < Package
  description 'Shotcut is a free, open source, cross-platform video editor.'
  homepage 'https://www.shotcut.org/'
  version '20.11.25'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url 'https://github.com/mltframework/shotcut/releases/download/v20.11.25/shotcut-linux-x86_64-201125.txz'
    source_sha256 'fa45d26a1e1e6af82e4f600a7a98b020e1af14f9c176595567aacbb3c9f21093'
    depends_on 'gtk3'
    depends_on 'jack1'
    depends_on 'ffmpeg'
    depends_on 'sommelier'
  end

  binary_url ({
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/shotcut-20.11.25-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: 'c252f03d9b50f5533d86640734d2327ee6e364df79d3505e890da587d1b32efc',
  })

  def self.build
    system "cat << 'EOF' > shotcut
#!/bin/sh
# Set up environment
# Run this instead of trying to run bin/shotcut. It runs shotcut with the correct environment.
CURRENT_DIR=\$(readlink -f \"\$0\")
INSTALL_DIR=#{CREW_PREFIX}/share/shotcut
export LD_LIBRARY_PATH=\"\$INSTALL_DIR/lib\":\$LD_LIBRARY_PATH
export MLT_REPOSITORY=\"\$INSTALL_DIR/lib/mlt\"
export MLT_DATA=\"\$INSTALL_DIR/share/mlt\"
export MLT_PROFILES_PATH=\"\$INSTALL_DIR/share/mlt/profiles\"
export MLT_MOVIT_PATH=\"\$INSTALL_DIR/share/movit\"
export FREI0R_PATH=\"\$INSTALL_DIR/lib/frei0r-1\"
# Temporarily ignore user and default path because csladspa bug is crashing with
# LADSPA_PATH set, and Shotcut only needs the supplied SWH plugins.
# export LADSPA_PATH=\"\$LADSPA_PATH:/usr/local/lib/ladspa:/usr/lib/ladspa:/usr/lib64/ladspa:\$INSTALL_DIR/lib/ladspa\"
export LADSPA_PATH=\"\$INSTALL_DIR/lib/ladspa\"
export LIBVA_DRIVERS_PATH=\"\$INSTALL_DIR/lib/va\"
cd \"\$INSTALL_DIR\"
export QT_PLUGIN_PATH=\"lib/qt5\"
export QML2_IMPORT_PATH=\"lib/qml\"
bin/shotcut \"\$@\"
EOF"
  end

  def self.install
    Dir.chdir 'Shotcut.app' do
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/shotcut"
      FileUtils.mv 'bin', "#{CREW_DEST_PREFIX}/share/shotcut"
      FileUtils.mv 'lib', "#{CREW_DEST_PREFIX}/share/shotcut"
      FileUtils.mv 'share', "#{CREW_DEST_PREFIX}/share/shotcut"
    end
    system "install -Dm755 shotcut #{CREW_DEST_PREFIX}/bin/shotcut"
    system "install -Dm644 Shotcut.desktop #{CREW_DEST_PREFIX}/share/applications/Shotcut.desktop"
  end
end
