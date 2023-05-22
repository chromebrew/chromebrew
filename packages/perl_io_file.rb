require 'package'

class Perl_io_file < Package
  description 'Supply object methods for filehandles'
  homepage 'https://metacpan.org/pod/IO::File'
  version '1.51-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/T/TO/TODDR/IO-1.51.tar.gz'
  source_sha256 '5493ea55998728cd2b7ecb8234c58fb5d5df27098d0f07addca22444d7616ce0'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_file/1.51-perl5.36_i686/perl_io_file-1.51-perl5.36-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_file/1.51-perl5.36_x86_64/perl_io_file-1.51-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: 'f58d3cbf2c72867f2f5be09bd64aea5e9e90f772af466b037b8cab1bf51332e6',
  x86_64: '7669b1f01815221c7bec2606a4552c4ed220de8a66c0741c2c9a4118b07a631f'
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
