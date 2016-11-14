require 'package'

class Gawk < Package
  version '4.1.1'
  source_url 'http://ftp.gnu.org/gnu/gawk/gawk-4.1.1.tar.gz'
  source_sha1 '0480d23fffbf04bfd0d4ede4c1c3d57eb81cc771'
  binary_url({
    armv7l: "https://dl.dropboxusercontent.com/s/b7w6l92az4dmitf/gawk-4.1.1-chromeos-armv7l.tar.xz",
  })
  binary_sha1({
    armv7l: "470c7f9360d563d88031d793f7bbe39a972e2209",
  })

  def self.build
    system './configure --prefix=/usr/local'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
