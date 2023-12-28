require 'buildsystems/perl'

class Perl_data_dumper < PERL
  description 'Stringified perl data structures, suitable for both printing and eval'
  homepage 'https://metacpan.org/pod/Data::Dumper'
  version '2.183-perl5.38.1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/N/NW/NWCLARK/Data-Dumper-2.183.tar.gz'
  source_sha256 'e42736890b7dae1b37818d9c5efa1f1fdc52dec04f446a33a4819bf1d4ab5ad3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_data_dumper/2.183-perl5.38.1_armv7l/perl_data_dumper-2.183-perl5.38.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_data_dumper/2.183-perl5.38.1_armv7l/perl_data_dumper-2.183-perl5.38.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_data_dumper/2.183-perl5.38.1_i686/perl_data_dumper-2.183-perl5.38.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_data_dumper/2.183-perl5.38.1_x86_64/perl_data_dumper-2.183-perl5.38.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a84771f335e4abda1b93d42a18df2228d71ee8ca5cab9e0746d75e17d19e6e86',
     armv7l: 'a84771f335e4abda1b93d42a18df2228d71ee8ca5cab9e0746d75e17d19e6e86',
       i686: '36f12a25b3fb213c43b2e34bfa2b758c5041a724dc78c665e981fb30f0b4f24a',
     x86_64: 'cb8bf660baf46e2762b45df7801d7b95c519c4d3ae7e03d80295c76d853bbe5b'
  })

  depends_on 'glibc' # R

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
