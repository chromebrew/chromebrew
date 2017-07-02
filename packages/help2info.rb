require 'package'

class Help2info < Package
  description 'help2info is a bash script that generates a simple info page from the output of the --help argument of the specified program.'
  homepage 'http://savannah.nongnu.org/projects/help2info'
  version '0.1.1'
  source_url 'http://download.savannah.nongnu.org/releases/help2info/help2info-0.1.1.tar.bz2'
  source_sha256 '9964fa462fb3e0f0646c97d986b69b3365461e94365cd80c5ec57f03ca08a839'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
