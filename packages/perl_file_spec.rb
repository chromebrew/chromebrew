require 'package'

class Perl_file_spec < Package
  description 'Portably perform operations on file names'
  homepage 'https://metacpan.org/pod/File::Spec'
  version '3.75-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XS/XSAWYERX/PathTools-3.75.tar.gz'
  source_sha256 'a558503aa6b1f8c727c0073339081a77888606aa701ada1ad62dd9d8c3f945a2'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_spec/3.75-perl5.36_armv7l/perl_file_spec-3.75-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_spec/3.75-perl5.36_armv7l/perl_file_spec-3.75-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_spec/3.75-perl5.36_i686/perl_file_spec-3.75-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_spec/3.75-perl5.36_x86_64/perl_file_spec-3.75-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '92dd8fc899f16c274176bceb40abe5475bef091021d1c860ac1c80e7dc28f373',
     armv7l: '92dd8fc899f16c274176bceb40abe5475bef091021d1c860ac1c80e7dc28f373',
       i686: '6812f3f20da09ba3ad558e3c654b05ac19196bb1e61f49156c01f29fe6544b9f',
     x86_64: 'bc43b40ece9e8712dc044eac15fd517dcd85281706c6aa10904e690164982e7a'
  })

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
      if File.exist?("#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}.3")
        FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}.3",
                     "#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}-#{name}.3"
      end
    end
  end
end
