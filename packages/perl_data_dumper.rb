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
    aarch64: '25889f9f0ff5c0904d57c6299a6c612a77d8b35828839d65d107cb201f90853a',
     armv7l: '25889f9f0ff5c0904d57c6299a6c612a77d8b35828839d65d107cb201f90853a',
       i686: '0d89bd659f2721456a84736640bbc8f661c09489919a84c6c2c7e00fa8f3688b',
     x86_64: 'c477dd3877ca461687dba6a243f65ab07a45035df6b087be38f233ea250b71a4'
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
