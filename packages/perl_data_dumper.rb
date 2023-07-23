require 'package'

class Perl_data_dumper < Package
  description 'Stringified perl data structures, suitable for both printing and eval'
  homepage 'https://metacpan.org/pod/Data::Dumper'
  version '2.183-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/N/NW/NWCLARK/Data-Dumper-2.183.tar.gz'
  source_sha256 'e42736890b7dae1b37818d9c5efa1f1fdc52dec04f446a33a4819bf1d4ab5ad3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_data_dumper/2.183-perl5.38_armv7l/perl_data_dumper-2.183-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_data_dumper/2.183-perl5.38_armv7l/perl_data_dumper-2.183-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_data_dumper/2.183-perl5.38_i686/perl_data_dumper-2.183-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_data_dumper/2.183-perl5.38_x86_64/perl_data_dumper-2.183-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2918dfef51ffec3f9af6800e865cccc22e3afacf1e811cf3a26c42b2eb32ac14',
     armv7l: '2918dfef51ffec3f9af6800e865cccc22e3afacf1e811cf3a26c42b2eb32ac14',
       i686: '813e31e63a52e590ea14aea5f53d3dc9302aaca28ead44d95cd7a8bc4633a3e1',
     x86_64: '8162b6ee4a6c00804406b4ebd0de11d95e06fcc56cdfb7170f4a658fe4534b7a'
  })

  depends_on 'glibc' # R

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
      Data::Dumper
    ]
    @perl_conflicts.each do |conflict|
      if File.exist?("#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}.3")
        FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}.3",
                     "#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}-#{name}.3"
      end
    end
  end
end
