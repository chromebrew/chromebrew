require 'package'

class Rpm < Package
  description 'RedHat Package Manager is a free and open-source package management system and is the baseline package format of the Linux Standard Base.'
  homepage 'https://rpm.org'
  version '4.16.1.2'
  compatibility 'all'
  source_url 'http://ftp.rpm.org/releases/rpm-4.16.x/rpm-4.16.1.2.tar.bz2'
  source_sha256 '8357329ceefc92c41687988b22198b26f74a12a9a68ac00728f934a5c4b4cacc'

  depends_on 'openssl' # Could also be libgcrypt but I chose openssl because it's a base package
  depends_on 'popt' => :build
  depends_on 'libarchive' => :build
  depends_on 'libdb' => :build # I'm assuming these are build dependencies because the configure script was looking for header files not libraries or binaries, I could be wrong

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --with-crypto=openssl \
            --enable-python \
            --enable-sqlite \
            --without-lua" # configure script didn't like or couldn't find lua while installed
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
  
  def self.postinstall
    puts
    puts 'rpm is the RedHat package manager'.lightblue
    puts 'This is useful for those who want to create/modify rpm files'.lightblue
    puts 'However, do NOT use rpm to install rpms on your chromeos machine'.lightblue
    puts 'This may break your system; you may have to do a full recovery by USB'.lightblue
    puts "You've been warned!".lightblue
    puts
  end
end
