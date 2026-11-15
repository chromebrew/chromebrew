require 'buildsystems/perl'

class Perl_file_spec < PERL
  description 'Portably perform operations on file names'
  homepage 'https://metacpan.org/pod/File::Spec'
  version "3.75-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XS/XSAWYERX/PathTools-3.75.tar.gz'
  source_sha256 'a558503aa6b1f8c727c0073339081a77888606aa701ada1ad62dd9d8c3f945a2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ab1c6cc1c4368f817b562d1180e0c733e4b692f04f7d9f35446aebbc66b591d4',
     armv7l: 'ab1c6cc1c4368f817b562d1180e0c733e4b692f04f7d9f35446aebbc66b591d4',
       i686: '071e6f8a967e94f6989b550be121cc51365fc7a1faadf744a09cbd7e3e6ef20d',
     x86_64: '86aef81263a6a8d0384a80c347c4e17ebb0b0e5aa6b09ecadbc40a08084d0e25'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'perl' => :logical

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
