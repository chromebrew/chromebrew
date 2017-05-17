require 'package'

class Mandb < Package
  version '2.7.6'
  source_url 'https://download.savannah.gnu.org/releases/man-db/man-db-2.7.6.tar.xz'
  source_sha1 '35a10f80d5cf6411d5c73376fcddcec1539e788a'

  depends_on 'libpipeline'
  depends_on 'pkgconfig'
  depends_on 'gdbm'
  depends_on 'groff'
  depends_on 'less'

  def self.build
    system './configure',
      '--with-systemdtmpfilesdir=/usr/local/lib/tmpfiles.d',  # we can't write to /usr/lib/tmpfiles.d
      '--disable-cache-owner',                                # we can't create the user 'man'
      '--with-pager=/usr/local/bin/less'                      # the pager is not at the default location
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "if [ ! -d /var/cache/man ]; then sudo mkdir /var/cache/man; fi"
    system "sudo chown -R chronos:chronos /var/cache/man"
    puts ""
    puts "You will have to change the default PAGER environment variable to be able to use mandb:"
    puts "echo \"export PAGER=/usr/local/bin/less\" >> ~/.bashrc && . ~/.bashrc"
    puts ""
    puts "You will also have to set the MANPATH environment variable:"
    puts "echo \"export MANPATH=/usr/local/man:$MANPATH\" >> ~/.bashrc && . ~/.bashrc"
    puts ""
    puts "Type 'mandb -c' to add manual pages."
  end
end
