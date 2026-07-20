require 'buildsystems/perl'

class Perl_extutils_depends < PERL
  description 'Easily build XS extensions that depend on XS extensions'
  homepage 'https://metacpan.org/pod/ExtUtils::Depends'
  version "0.8001-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/X/XA/XAOC/ExtUtils-Depends-#{version.split('-')[0]}.tar.gz"
  source_sha256 '673c4387e7896c1a216099c1fbb3faaa7763d7f5f95a1a56a60a2a2906c131c5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c950578220f43d17590ca02a103489ecd20ffe6504054c55530d89a9670ad22a',
     armv7l: 'c950578220f43d17590ca02a103489ecd20ffe6504054c55530d89a9670ad22a',
       i686: '512b5e2f24880660329daa10b28413bff42878c9393d0a02f049a54fe9e8ab06',
     x86_64: 'dbc6bdadb1b040d552e522b9590b31a8d1abd1f4a4f4f2f5c69a314cdc7694ef'
  })

  depends_on 'perl' => :logical
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
