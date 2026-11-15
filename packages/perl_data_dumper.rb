require 'buildsystems/perl'

class Perl_data_dumper < PERL
  description 'Stringified perl data structures, suitable for both printing and eval'
  homepage 'https://metacpan.org/pod/Data::Dumper'
  version "2.183-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/N/NW/NWCLARK/Data-Dumper-2.183.tar.gz'
  source_sha256 'e42736890b7dae1b37818d9c5efa1f1fdc52dec04f446a33a4819bf1d4ab5ad3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fca9b8490b1a7ba20a237ca09e1901183a8e07ba0d837e18239e6b1aa131f95d',
     armv7l: 'fca9b8490b1a7ba20a237ca09e1901183a8e07ba0d837e18239e6b1aa131f95d',
       i686: '2aec8f6c6a095f5015c453ed8426766dd16d2c11c897ae8cc666dd8a8c5c8ad6',
     x86_64: '48ac7cc989f1b994a404699b8f8112cf72790a6d0d720e521094a8dc13732ba3'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'perl' => :logical

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
