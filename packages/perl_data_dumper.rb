require 'buildsystems/perl'

class Perl_data_dumper < PERL
  description 'Stringified perl data structures, suitable for both printing and eval'
  homepage 'https://metacpan.org/pod/Data::Dumper'
  version '2.183-perl5.38.2'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/N/NW/NWCLARK/Data-Dumper-2.183.tar.gz'
  source_sha256 'e42736890b7dae1b37818d9c5efa1f1fdc52dec04f446a33a4819bf1d4ab5ad3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_data_dumper/2.183-perl5.38.2_armv7l/perl_data_dumper-2.183-perl5.38.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_data_dumper/2.183-perl5.38.2_armv7l/perl_data_dumper-2.183-perl5.38.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_data_dumper/2.183-perl5.38.2_i686/perl_data_dumper-2.183-perl5.38.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_data_dumper/2.183-perl5.38.2_x86_64/perl_data_dumper-2.183-perl5.38.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fffc682fd6fffe423613a125f72886456e7e95ee9466a915812823c62acdd8b5',
     armv7l: 'fffc682fd6fffe423613a125f72886456e7e95ee9466a915812823c62acdd8b5',
       i686: '462194d705d9905e596fb7bc7740f89b1a8037f67f7ab823a2380db60fa11317',
     x86_64: '15895d247fc6e60f155554323b538edce8cffbe126233a63d6c76f20688f90bf'
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
