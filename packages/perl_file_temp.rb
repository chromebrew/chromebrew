require 'package'

class Perl_file_temp < Package
  description 'Return name and handle of a temporary file safely'
  homepage 'https://metacpan.org/pod/File::Temp'
  version '0.2311-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/File-Temp-0.2311.tar.gz'
  source_sha256 '2290d61bf5c39882fc3311da9ce1c7f42dbdf825ae169e552c59fe4598b36f4a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_temp/0.2311-perl5.38_armv7l/perl_file_temp-0.2311-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_temp/0.2311-perl5.38_armv7l/perl_file_temp-0.2311-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_temp/0.2311-perl5.38_i686/perl_file_temp-0.2311-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_temp/0.2311-perl5.38_x86_64/perl_file_temp-0.2311-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7e0b85f9f48a3a850dee56e5e282b8121c83e2c46498ecffc784ce12556477bd',
     armv7l: '7e0b85f9f48a3a850dee56e5e282b8121c83e2c46498ecffc784ce12556477bd',
       i686: 'ef0637a3bb8f99f4c013487557efd0f57d89fd55ae056556e9975e4bf53af380',
     x86_64: '67d076fbd4a469db6259b103045dac746956084958254a8909c0c0cdbcf4ffa3'
  })

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
