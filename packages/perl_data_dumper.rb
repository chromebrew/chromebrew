require 'package'

class Perl_data_dumper < Package
  description 'Stringified perl data structures, suitable for both printing and eval'
  homepage 'https://metacpan.org/pod/Data::Dumper'
  version '2.183-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/N/NW/NWCLARK/Data-Dumper-2.183.tar.gz'
  source_sha256 'e42736890b7dae1b37818d9c5efa1f1fdc52dec04f446a33a4819bf1d4ab5ad3'

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
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/Data::Dumper.3", "#{CREW_DEST_MAN_PREFIX}/man3/Data::Dumper-perl_data_dumper.3"
  end
end
