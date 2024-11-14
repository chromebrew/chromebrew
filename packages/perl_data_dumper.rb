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
    aarch64: '0f575f41b78b9d67f73d2bd11163d442c5e838db06a868b8d8e52b0942b9ec82',
     armv7l: '0f575f41b78b9d67f73d2bd11163d442c5e838db06a868b8d8e52b0942b9ec82',
       i686: '9d75a00164fb9dcd1dfa4502e1b4f863e339c2cea5359cdb1e81bbd25eddb59a',
     x86_64: '84cae248b99fa81f5399483f1955aed5f5b51d939d54f8433012f6127f3e66fa'
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
