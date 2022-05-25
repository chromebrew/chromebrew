require 'package'

class Perl_extutils_depends < Package
  description 'Easily build XS extensions that depend on XS extensions'
  homepage 'https://metacpan.org/pod/ExtUtils::Depends'
  version '0.8001-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/ExtUtils-Depends-0.8001.tar.gz'
  source_sha256 '673c4387e7896c1a216099c1fbb3faaa7763d7f5f95a1a56a60a2a2906c131c5'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_extutils_depends/0.8001-perl5.38_armv7l/perl_extutils_depends-0.8001-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_extutils_depends/0.8001-perl5.38_armv7l/perl_extutils_depends-0.8001-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_extutils_depends/0.8001-perl5.38_i686/perl_extutils_depends-0.8001-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_extutils_depends/0.8001-perl5.38_x86_64/perl_extutils_depends-0.8001-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4568b77c1c28dda83b70c5da7d2a16fe29a87d76f1c9269148b1ae7a2be6682f',
     armv7l: '4568b77c1c28dda83b70c5da7d2a16fe29a87d76f1c9269148b1ae7a2be6682f',
       i686: '9497b7ab5974749ca52fb464e6f87c59fdf0c2e6126cc38a289bfdf4ee910418',
     x86_64: '6f7828277631c5ce6a1821a1f415543f2a16aa95f452e34aaea37b8817ea6483'
  })

  depends_on 'perl_data_dumper' => :build
  depends_on 'perl_extutils_makemaker' => :build
  depends_on 'perl_file_spec' => :build
  depends_on 'perl_io_file' => :build

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
