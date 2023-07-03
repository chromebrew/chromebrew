require 'package'

class Perl_file_spec < Package
  description 'Portably perform operations on file names'
  homepage 'https://metacpan.org/pod/File::Spec'
  version '3.75-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XS/XSAWYERX/PathTools-3.75.tar.gz'
  source_sha256 'a558503aa6b1f8c727c0073339081a77888606aa701ada1ad62dd9d8c3f945a2'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_spec/3.75-perl5.38_armv7l/perl_file_spec-3.75-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_spec/3.75-perl5.38_armv7l/perl_file_spec-3.75-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_spec/3.75-perl5.38_i686/perl_file_spec-3.75-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_spec/3.75-perl5.38_x86_64/perl_file_spec-3.75-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '15161e8a0c2ba7aada4dbfeda8e65e61c7208440ed5c0b2482a0451dfcc9e882',
     armv7l: '15161e8a0c2ba7aada4dbfeda8e65e61c7208440ed5c0b2482a0451dfcc9e882',
       i686: 'd95cf0fcbbe3a40a4ba9be8f140c28701310c52c74156ad5e5e4f439dc82dfd7',
     x86_64: '4bdb0f957b2a3429ca3f710326b25fba1e2aef5752caf41dbdcb8e2bd33606de'
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
