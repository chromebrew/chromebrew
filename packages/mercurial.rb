require 'package'

class Mercurial < Package
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version '4.2.2'
  compatibility 'all'
  source_url 'https://www.mercurial-scm.org/release/mercurial-4.2.2.tar.gz'
  source_sha256 'b20132dec5ae6d27ee43a133144069895befe09f7e454bfa9e39950a185f0afe'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mercurial-4.2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mercurial-4.2.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mercurial-4.2.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mercurial-4.2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '80f381f790326ad000501235b038d3f0633a6ac001d1bdb6969a7a0b3dd981da',
     armv7l: '80f381f790326ad000501235b038d3f0633a6ac001d1bdb6969a7a0b3dd981da',
       i686: '56f202784a34ae85917da536732f2d1897b4efef3cf1214272850598d363d4f1',
     x86_64: '5e33ff3958f26ff084330c833b90afd90314f28f9d60ec17150be63ab4b7e305',
  })

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
    system "make", "PREFIX=#{CREW_PREFIX}", "all"
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
