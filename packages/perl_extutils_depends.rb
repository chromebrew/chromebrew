require 'buildsystems/perl'

class Perl_extutils_depends < PERL
  description 'Easily build XS extensions that depend on XS extensions'
  homepage 'https://metacpan.org/pod/ExtUtils::Depends'
  version "0.8001-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/ExtUtils-Depends-0.8001.tar.gz'
  source_sha256 '673c4387e7896c1a216099c1fbb3faaa7763d7f5f95a1a56a60a2a2906c131c5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6baa0e2745a9a7db5c5d1df7d3e337b952f86caa2f59bfd64d2715484f3d7301',
     armv7l: '6baa0e2745a9a7db5c5d1df7d3e337b952f86caa2f59bfd64d2715484f3d7301',
       i686: '106fc60092e10c02a14a6b6dddbcd6062f9dbf9bb0023589aba1079fb57aa2c0',
     x86_64: '7392bfba3d04eb816e474eecc2e5a7ea050a4efb4a69cd8444476bd41ecc5d69'
  })

  depends_on 'perl_data_dumper' => :build
  depends_on 'perl_extutils_makemaker' => :build
  depends_on 'perl_file_spec' => :build
  depends_on 'perl_io_file' => :build

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
