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
    aarch64: '62f6b26abb4f9df8b5601f9990e554502f527a090d8d722f51f1542f9e29bc8a',
     armv7l: '62f6b26abb4f9df8b5601f9990e554502f527a090d8d722f51f1542f9e29bc8a',
       i686: '8e1a67786b2de6327b71f5db90656d68173ce0d041d50f3d61651c8c5daeb34b',
     x86_64: 'bae7efeca38cf60dd8ed48cc524921e2049f371c1436b7bb1af355f3959a7417'
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
