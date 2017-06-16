require 'package'

class Mandb < Package
  description 'mandb is used to initialise or manually update index database caches that are usually maintained by man.'
  homepage 'http://savannah.nongnu.org/projects/man-db'
  version '2.7.6.1'
  source_url 'http://download.savannah.gnu.org/releases/man-db/man-db-2.7.6.1.tar.xz'
  source_sha1 '919dcb34d604faac9b18a38ead07f457d0dab501'

  depends_on 'less'
  depends_on 'libpipeline'
  depends_on 'gdbm'
  depends_on 'groff'
  depends_on 'pkgconfig'
  depends_on 'readline'

  def self.build
    system './configure',
      '--with-systemdtmpfilesdir=/usr/local/lib/tmpfiles.d',  # we can't write to /usr/lib/tmpfiles.d
      '--disable-cache-owner',                                # we can't create the user 'man'
      '--with-pager=/usr/local/bin/less'                      # the pager is not at the default location
    system 'make'
    system "find . -name 'lib*.so*' -print | xargs strip -S"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
    puts ""
    puts "You will have to change the default PAGER environment variable to be able to use mandb:"
    puts "echo \"export PAGER=/usr/local/bin/less\" >> ~/.bashrc && . ~/.bashrc"
    puts ""
    puts "You will also have to set the MANPATH environment variable:"
    puts "echo \"export MANPATH=/usr/local/man:$MANPATH\" >> ~/.bashrc && . ~/.bashrc"
  end
end
