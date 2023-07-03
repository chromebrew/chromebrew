require 'package'

class Perl_io_file < Package
  description 'Supply object methods for filehandles'
  homepage 'https://metacpan.org/pod/IO::File'
  version '1.51-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/T/TO/TODDR/IO-1.51.tar.gz'
  source_sha256 '5493ea55998728cd2b7ecb8234c58fb5d5df27098d0f07addca22444d7616ce0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_file/1.51-perl5.38_armv7l/perl_io_file-1.51-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_file/1.51-perl5.38_armv7l/perl_io_file-1.51-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_file/1.51-perl5.38_i686/perl_io_file-1.51-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_file/1.51-perl5.38_x86_64/perl_io_file-1.51-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b72491694be1f3fb2333fd5b164a1a2d7e4e4e44f3b04efde49c0045b12de068',
     armv7l: 'b72491694be1f3fb2333fd5b164a1a2d7e4e4e44f3b04efde49c0045b12de068',
       i686: 'f17926d2b1a228fed01a3c2295f10623a30e7ebd3db920468ebb468abf1b5049',
     x86_64: 'e19cddaa4049d2adf964e8113649dc01d9a7e410d1ef2e087956da5df47b5d41'
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
