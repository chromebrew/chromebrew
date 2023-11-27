require 'package'

class Perl_file_spec < Package
  description 'Portably perform operations on file names'
  homepage 'https://metacpan.org/pod/File::Spec'
  version '3.75-perl5.38.1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XS/XSAWYERX/PathTools-3.75.tar.gz'
  source_sha256 'a558503aa6b1f8c727c0073339081a77888606aa701ada1ad62dd9d8c3f945a2'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_spec/3.75-perl5.38.1_armv7l/perl_file_spec-3.75-perl5.38.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_spec/3.75-perl5.38.1_armv7l/perl_file_spec-3.75-perl5.38.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_spec/3.75-perl5.38.1_i686/perl_file_spec-3.75-perl5.38.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_spec/3.75-perl5.38.1_x86_64/perl_file_spec-3.75-perl5.38.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'edd66e329450f8a7ad8b22247db535399114e312d995e6b7984ad1892b6dce69',
     armv7l: 'edd66e329450f8a7ad8b22247db535399114e312d995e6b7984ad1892b6dce69',
       i686: 'f5c837d401f60dd6fe10e6a67992db07f883339805d26c367ba332d713d36c53',
     x86_64: '0e7ca9cb21e8f99f7f986e5a92ab344551bc2c41ec5fd8f4f3cceb5ab77b7ef8'
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
