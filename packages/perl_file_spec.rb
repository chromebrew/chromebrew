require 'package'

class Perl_file_spec < Package
  description 'Portably perform operations on file names'
  homepage 'https://metacpan.org/pod/File::Spec'
  version '3.75-perl5.36'
  compatibility 'all'
  license 'GPL-1+ or Artistic'
  source_url 'https://cpan.metacpan.org/authors/id/X/XS/XSAWYERX/PathTools-3.75.tar.gz'
  source_sha256 'a558503aa6b1f8c727c0073339081a77888606aa701ada1ad62dd9d8c3f945a2'

  depends_on 'glibc' # R

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
      Cwd
      File::Spec
      File::Spec::AmigaOS
      File::Spec::Cygwin
      File::Spec::Epoc
      File::Spec::Functions
      File::Spec::Mac
      File::Spec::OS2
      File::Spec::Unix
      File::Spec::VMS
      File::Spec::Win32
    ]
    @perl_conflicts.each do |conflict|
      FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}.3", "#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}-#{name}.3"
    end
  end
end
