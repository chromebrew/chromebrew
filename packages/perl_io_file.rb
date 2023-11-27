require 'package'

class Perl_io_file < Package
  description 'Supply object methods for filehandles'
  homepage 'https://metacpan.org/pod/IO::File'
  version '1.51-perl5.38.1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/T/TO/TODDR/IO-1.51.tar.gz'
  source_sha256 '5493ea55998728cd2b7ecb8234c58fb5d5df27098d0f07addca22444d7616ce0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_file/1.51-perl5.38.1_armv7l/perl_io_file-1.51-perl5.38.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_file/1.51-perl5.38.1_armv7l/perl_io_file-1.51-perl5.38.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_file/1.51-perl5.38.1_i686/perl_io_file-1.51-perl5.38.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_file/1.51-perl5.38.1_x86_64/perl_io_file-1.51-perl5.38.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '43f5e4e2ce689bb69da90795d1f1f9717b81c18870df1385646bcc528321991c',
     armv7l: '43f5e4e2ce689bb69da90795d1f1f9717b81c18870df1385646bcc528321991c',
       i686: '824fab2a6ce284b91445cfef08a1409eb9ef31895667221dfa57ea5f358d8401',
     x86_64: 'b6f72518c8e18a0200fd02fae85ce62eb4cf8651e3c4cf601057af46660d3205'
  })

  depends_on 'perl_file_temp' => :build
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
      File::Temp
      IO::Pipe
      IO::Poll
      IO::Seekable
      IO::Select
      IO::Socket
      IO::Socket::INET
      IO::Socket::UNIX
      IO
      IO::Dir
      IO::File
      IO::Handle
    ]
    @perl_conflicts.each do |conflict|
      if File.exist?("#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}.3")
        FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}.3",
                     "#{CREW_DEST_MAN_PREFIX}/man3/#{conflict}-#{name}.3"
      end
    end
  end
end
