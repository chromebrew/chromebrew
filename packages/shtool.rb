require 'package'

class Shtool < Package
  description 'GNU shtool is a compilation of small but very stable and portable shell scripts into a single shell tool.'
  homepage 'http://savannah.gnu.org/projects/shtool'
  version '2.0.8'
  source_url 'http://ftp.gnu.org/gnu/shtool/shtool-2.0.8.tar.gz'
  source_sha1 '4b974f92d3932ea121e311e3b22c328d3b3572d4'
  #source_sha256 '1298a549416d12af239e9f4e787e6e6509210afb49d5cf28eb6ec4015046ae19'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/man/man1"
    system "cp shtool #{CREW_DEST_DIR}/usr/local/bin"
    system "cp *.1 #{CREW_DEST_DIR}/usr/local/man/man1"
  end
end
