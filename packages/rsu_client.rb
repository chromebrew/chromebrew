require 'package'

class Rsu_client < Package
  description 'RSU-Client is a RuneScape Client Launcher written for the now Legacy client and now OldSchool.'
  homepage 'https://github.com/rsu-client/rsu-client'
  version '4.3.7'
  source_url 'https://github.com/rsu-client/rsu-client/archive/v4.3.7.tar.gz'
  source_sha256 '7cc589de111baad956c0c41a4d7f1b45168886bf623dd3886d07fa3d1dfd604c'

  depends_on 'jdk8'
  depends_on 'p7zip'
  depends_on 'wxwidgets'
  depends_on 'xdg_utils'
  depends_on 'sommelier'

  def self.patch
    Dir.chdir 'runescape' do
      system "for f in \$(grep -r /usr/bin .|egrep -v '^Binary'|egrep -o '^[^:]+');do
                sed -i 's,/usr/local,/usr,g' \${f}
              done"
      system "for f in \$(grep -r /usr/bin .|egrep -v '^Binary'|egrep -o '^[^:]+');do
                sed -i 's,/usr,#{CREW_PREFIX},g' \${f}
              done"
    end
  end

  def self.build
    system 'cpan install Archive::Extract exit'
  end

  def self.install
    system 'mkdir', '-p', "#{CREW_DEST_PREFIX}/share"
    system 'cp', '-a', 'runescape', "#{CREW_DEST_PREFIX}/share/"
    system 'mkdir', '-p', "#{CREW_DEST_PREFIX}/bin"
    system 'ln', '-s', "#{CREW_PREFIX}/share/runescape/runescape", "#{CREW_DEST_PREFIX}/bin/runescape"
  end
end
