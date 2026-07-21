require 'buildsystems/perl'

class Perl_file_temp < PERL
  description 'Return name and handle of a temporary file safely'
  homepage 'https://metacpan.org/pod/File::Temp'
  version "0.2312-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/File-Temp-#{version.split('-')[0]}.tar.gz"
  source_sha256 '6fa961d955cf84d5b87f2f219a723cf77cb44b79282793f6819ccb19e8d0b884'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '',
     armv7l: '',
       i686: '2f3529cad14b3d7cad87c86bb6f9f0c82aa02fc0bfcad46e759c194765bf939d',
     x86_64: 'e8cef1dc9ce781afa80cac42f5e8214162ac27296993d2cb0578b55c08c41638'
  })

  binary_sha256({
    aarch64: '45036d05f425edb77c425c0b3ccd509dc2fa34a6f77413dc8f31963024e05020',
     armv7l: '45036d05f425edb77c425c0b3ccd509dc2fa34a6f77413dc8f31963024e05020',
       i686: 'd5a824c39086ea2fa893bfb257d30eece51a6891ed21dc4f4be3315895617aad',
     x86_64: 'bf53a24609d7dfc94545106998e9713321760de8f30e542ff3c8338c1462aa57'
  })

  depends_on 'perl' => :logical

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    @perl_conflicts = %w[
      File::Temp
    ]
    @perl_conflicts.each do |conflict|
      if File.exist?("#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}.3")
        FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}.3",
                     "#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}-#{name}.3"
      end
    end
  end
end
