require 'package'

class Rsu_client < Package
  description 'RSU-Client is a RuneScape Client Launcher written for the now Legacy client and now OldSchool.'
  homepage 'https://github.com/rsu-client/rsu-client'
  version '4.3.7'
  source_url 'https://github.com/rsu-client/rsu-client/archive/v4.3.7.tar.gz'
  source_sha256 '7cc589de111baad956c0c41a4d7f1b45168886bf623dd3886d07fa3d1dfd604c'

  depends_on 'jdk8'
  depends_on 'p7zip'
  depends_on 'perl'
  depends_on 'wxwidgets'
  depends_on 'xdg_utils'
  depends_on 'sommelier'

  def self.patch
    Dir.chdir 'runescape' do
      system "sed -i 's,#{CREW_PREFIX},/usr,gw /dev/stdout' ./changelog.txt"
      system "sed -i 's,#{CREW_PREFIX},/usr,gw /dev/stdout' ./install-desktop-icons"
      system "sed -i 's,#{CREW_PREFIX},/usr,gw /dev/stdout' ./rsu-settings"
      system "sed -i 's,#{CREW_PREFIX},/usr,gw /dev/stdout' ./rsu/bin/rsu-query-unix"
      system "sed -i 's,#{CREW_PREFIX},/usr,gw /dev/stdout' ./rsu/framework/API/client/launch/launcher.pm"
      system "sed -i 's,#{CREW_PREFIX},/usr,gw /dev/stdout' ./rsu/framework/Perl5lib/XML/RSSLite.pm"
      system "sed -i 's,#{CREW_PREFIX},/usr,gw /dev/stdout' ./rsu/framework/modules/rsu/java/jre.pm"
      system "sed -i 's,#{CREW_PREFIX},/usr,gw /dev/stdout' ./rsu/framework/modules/rsu/mains.pm"
      system "sed -i 's,#{CREW_PREFIX},/usr,gw /dev/stdout' ./rsu/framework/modules/rsu/nvidia/optimus.pm"
      system "sed -i 's,#{CREW_PREFIX},/usr,gw /dev/stdout' ./rsu/framework/modules/updater/download/sysdload.pm"
      system "sed -i 's,#{CREW_PREFIX},/usr,gw /dev/stdout' ./rsu/framework/modules/updater/download/wxsysdload.pm"
      system "sed -i 's,#{CREW_PREFIX},/usr,gw /dev/stdout' ./rsu/framework/modules/updater/gui/zenity.pm"
      system "sed -i 's,#{CREW_PREFIX},/usr,gw /dev/stdout' ./rsu/rsu-query"
      system "sed -i 's,#{CREW_PREFIX},/usr,gw /dev/stdout' ./runescape"
      system "sed -i 's,#{CREW_PREFIX},/usr,gw /dev/stdout' ./templates/packaging/usr/games/rsu-settings"
      system "sed -i 's,#{CREW_PREFIX},/usr,gw /dev/stdout' ./templates/packaging/usr/games/runescape"
      system "sed -i 's,#{CREW_PREFIX},/usr,gw /dev/stdout' ./templates/packaging/usr/games/update-runescape-client"
      system "sed -i 's,#{CREW_PREFIX},/usr,gw /dev/stdout' ./templates/packaging/usr/local/bin/xdg-open"
      system "sed -i 's,#{CREW_PREFIX},/usr,gw /dev/stdout' ./templates/protocol/install-jagex-protocol-linux"
      system "sed -i 's,#{CREW_PREFIX},/usr,gw /dev/stdout' ./updater"

      system "sed -i 's,/usr,#{CREW_PREFIX},gw /dev/stdout' ./changelog.txt"
      system "sed -i 's,/usr,#{CREW_PREFIX},gw /dev/stdout' ./install-desktop-icons"
      system "sed -i 's,/usr,#{CREW_PREFIX},gw /dev/stdout' ./rsu-settings"
      system "sed -i 's,/usr,#{CREW_PREFIX},gw /dev/stdout' ./rsu/bin/rsu-query-unix"
      system "sed -i 's,/usr,#{CREW_PREFIX},gw /dev/stdout' ./rsu/framework/API/client/launch/launcher.pm"
      system "sed -i 's,/usr,#{CREW_PREFIX},gw /dev/stdout' ./rsu/framework/Perl5lib/XML/RSSLite.pm"
      system "sed -i 's,/usr,#{CREW_PREFIX},gw /dev/stdout' ./rsu/framework/modules/rsu/java/jre.pm"
      system "sed -i 's,/usr,#{CREW_PREFIX},gw /dev/stdout' ./rsu/framework/modules/rsu/mains.pm"
      system "sed -i 's,/usr,#{CREW_PREFIX},gw /dev/stdout' ./rsu/framework/modules/rsu/nvidia/optimus.pm"
      system "sed -i 's,/usr,#{CREW_PREFIX},gw /dev/stdout' ./rsu/framework/modules/updater/download/sysdload.pm"
      system "sed -i 's,/usr,#{CREW_PREFIX},gw /dev/stdout' ./rsu/framework/modules/updater/download/wxsysdload.pm"
      system "sed -i 's,/usr,#{CREW_PREFIX},gw /dev/stdout' ./rsu/framework/modules/updater/gui/zenity.pm"
      system "sed -i 's,/usr,#{CREW_PREFIX},gw /dev/stdout' ./rsu/rsu-query"
      system "sed -i 's,/usr,#{CREW_PREFIX},gw /dev/stdout' ./runescape"
      system "sed -i 's,/usr,#{CREW_PREFIX},gw /dev/stdout' ./templates/packaging/usr/games/rsu-settings"
      system "sed -i 's,/usr,#{CREW_PREFIX},gw /dev/stdout' ./templates/packaging/usr/games/runescape"
      system "sed -i 's,/usr,#{CREW_PREFIX},gw /dev/stdout' ./templates/packaging/usr/games/update-runescape-client"
      system "sed -i 's,/usr,#{CREW_PREFIX},gw /dev/stdout' ./templates/packaging/usr/local/bin/xdg-open"
      system "sed -i 's,/usr,#{CREW_PREFIX},gw /dev/stdout' ./templates/protocol/install-jagex-protocol-linux"
      system "sed -i 's,/usr,#{CREW_PREFIX},gw /dev/stdout' ./updater"
    end
  end

  def self.build
    system 'cpan install Archive::Extract exit'
  end

  def self.install
    system 'mkdir', '-pv', "#{CREW_DEST_PREFIX}/share"
    system 'cp', '-rv', 'runescape', "#{CREW_DEST_PREFIX}/share/"
    system 'mkdir', '-pv', "#{CREW_DEST_PREFIX}/bin"
    system 'ln', '-sv', "#{CREW_PREFIX}/share/runescape/runescape", "#{CREW_DEST_PREFIX}/bin/runescape"
  end
end
