require 'package'

class Perl_file_temp < Package
  description 'Return name and handle of a temporary file safely'
  homepage 'https://metacpan.org/pod/File::Temp'
  version '0.2311-perl5.36'
  compatibility 'all'
  license 'GPL-1+ or Artistic'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/File-Temp-0.2311.tar.gz'
  source_sha256 '2290d61bf5c39882fc3311da9ce1c7f42dbdf825ae169e552c59fe4598b36f4a'

  no_compile_needed

  def self.prebuild
    system 'perl', 'Makefile.PL'
    system "sed -i 's,/usr/local,#{CREW_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    @perl_conflicts = %w[
      File::Temp
    ]
    @perl_conflicts.each do |conflict|
      FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}.3", "#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}-#{name}.3"
    end
  end
end
