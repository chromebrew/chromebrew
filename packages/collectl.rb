require 'package'

class Collectl < Package
  description 'Collectl is a light-weight performance monitoring tool capable of reporting interactively as well as logging to disk.'
  homepage 'https://collectl.sourceforge.net/'
  version '4.3.20.2'
  license 'GPL-2 and Artistic'
  compatibility 'all'
  source_url 'https://github.com/sharkcz/collectl.git'
  git_hashtag version

  no_compile_needed
  no_fhs

  def self.patch
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' colmux"
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' collectl"
    system "sed -i 's,/etc/\$ConfigFile,#{CREW_PREFIX}/etc/\$ConfigFile,' collectl"
    system "sed -i 's,DESTDIR=\${DESTDIR:=\"/\"},DESTDIR=#{CREW_DEST_PREFIX},' INSTALL"
    system "sed -i 's,\$DESTDIR/usr,\$DESTDIR,g' INSTALL"
    system "sed -i 's,/var/log,#{CREW_PREFIX}/logs,' INSTALL"
  end

  def self.install
    system './INSTALL'
  end
end
