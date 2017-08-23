require 'package'

class Mercurial < Package
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version '4.2.2'
  source_url 'https://www.mercurial-scm.org/release/mercurial-4.2.2.tar.gz'
  source_sha256 'b20132dec5ae6d27ee43a133144069895befe09f7e454bfa9e39950a185f0afe'

  # what's the best route for adding a minimum version symbol as a constraint?
  depends_on "python27"

  def self.build
    # would be great to avoid even downloading the source tarball if this dependency wasn't met
    py_ver = %x[python -V 2>&1 | awk '{ print $2 }'].strip
    abort '[!] python 2.7.13 or higher is required for tig, please run `crew upgrade python27` first.' unless py_ver > '2.7.12'
    if !%x[pip list | grep docutils].include? "docutils"
      puts "Installing docutils dependency..."
      system "pip", "install", "docutils"
    end
    system "make", "PREFIX=/usr/local", "all"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    puts "------------------"
    puts "Installation success!".lightgreen
    puts "Cleaning up dependencies only required for build..."
    system "pip", "uninstall", "docutils"
    puts
    puts "To begin using mercurial, you'll need to configure it.".lightblue
    puts
    puts "Run `hg debuginstall` and address any issues that it reports.".lightblue
    puts
  end
end
