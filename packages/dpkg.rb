require 'package'

class Dpkg < Package
  description 'A medium-level package manager for Debian'
  homepage 'https://anonscm.debian.org/git/dpkg/'
  version '1.19.0.5'
  source_url 'https://salsa.debian.org/dpkg-team/dpkg/-/archive/1.19.0.5/dpkg-1.19.0.5.tar.gz'
  source_sha256 'd38308afcd5d7896bbd1f946875b90f9d8510a8a96b44e4f14e781285e5d9641'

  depends_on 'icu4c' => :build

  def self.build
    system "git clone https://salsa.debian.org/dpkg-team/dpkg.git"
    Dir.chdir ("dpkg") do
      system "git checkout 1.19.0.5"
      system "autoreconf -i -f"
      system "./configure --libdir=#{CREW_LIB_PREFIX} --prefix=#{CREW_PREFIX}"
      system "make"
    end
  end

  def self.install
    Dir.chdir ("dpkg") do
      system "make install DESTDIR=#{CREW_DEST_DIR}"
      system "mkdir -p #{CREW_DEST_PREFIX}/usr/"
      system "ln -s #{CREW_PREFIX} #{CREW_DEST_PREFIX}/usr/local"
    end
  end
    def self.postinstall
    puts "You may need to run" 
    puts "'sudo chromeos-firmwareupdate --mode=todev',"
    puts "followed by 'sudo /usr/share/vboot/bin/make_dev_ssd.sh --remove_rootfs_verification',"
    puts "follow the instructions, and restart your Chromebook before installing packages."
    puts "However, this isn't necessary if you aren't going to use dpkg -i."
    system "echo >> /usr/local/var/lib/dpkg/status"
  end
end
