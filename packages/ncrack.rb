require 'package'

class Ncrack < Package
  description "Ncrack is a high-speed network authentication cracking tool."
  homepage 'https://nmap.org/ncrack/'
  version '0.5'
  source_url 'https://nmap.org/ncrack/dist/ncrack-0.5.tar.gz'
  source_sha256 'dbad9440c861831836d47ece95aeb2bd40374a3eb03a14dea0fe1bfa73ecd4bc'

  depends_on 'buildessential'

  def self.build
    system './configure --prefix=/usr/local'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
