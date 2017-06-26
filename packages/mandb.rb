require 'package'

class Mandb < Package
  description 'mandb is used to initialise or manually update index database caches that are usually maintained by man.'
  homepage 'http://savannah.nongnu.org/projects/man-db'
  version '2.7.6.1'
  source_url 'http://download.savannah.gnu.org/releases/man-db/man-db-2.7.6.1.tar.xz'
  source_sha256 '08edbc52f24aca3eebac429b5444efd48b9b90b9b84ca0ed5507e5c13ed10f3f'

  depends_on 'less'
  depends_on 'libpipeline'
  depends_on 'gdbm'
  depends_on 'groff'
  depends_on 'pkgconfig'
  depends_on 'readline'
  depends_on 'zlibpkg'

  def self.build
    system './configure',
      '--with-systemdtmpfilesdir=/usr/local/lib/tmpfiles.d',  # we can't write to /usr/lib/tmpfiles.d
      '--disable-cache-owner',                                # we can't create the user 'man'
      '--with-pager=/usr/local/bin/less'                      # the pager is not at the default location
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    puts ""
    puts "You will have to change the default PAGER environment variable to be able to use mandb:"
    puts "echo \"export PAGER=/usr/local/bin/less\" >> ~/.bashrc && . ~/.bashrc"
    puts ""
    puts "You will also have to set the MANPATH environment variable:"
    puts "echo \"export MANPATH=/usr/local/man:$MANPATH\" >> ~/.bashrc && . ~/.bashrc"
  end
end
