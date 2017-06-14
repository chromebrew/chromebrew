require 'package'

class Mercurial < Package
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version '4.1'
  source_url 'https://www.mercurial-scm.org/release/mercurial-4.1.tar.gz'
  source_sha1 'd5f88e05cbbd8f13dd5fc4004433f54435fc27c8'

  # what's the best route for adding a minimum version symbol as a constraint?
  depends_on "python27"

  def self.build
    # would be great to avoid even downloading the source tarball if this dependency wasn't met 
    py_ver = %x[python -V 2>&1 | awk '{ print $2 }'].strip
    abort '[!] python 2.7.13 or higher is required for tig, please run `crew upgrade python27` first.' unless py_ver > '2.7.12'
    if !%x[pip list | grep docutils].include? "docutils"
      puts "Installing docutils dependency..."
      system "sudo", "pip", "install", "docutils"
    end
    system "make", "PREFIX=/usr/local", "all"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
    puts "------------------"
    puts "Installation success!"
    puts "Cleaning up dependencies only required for build..."
    system "sudo", "pip", "uninstall", "docutils"
    puts
    puts "To begin using mercurial you'll need to configure it."
    puts
    puts "Run `hg debuginstall` and address any issues that it reports."
  end
end
