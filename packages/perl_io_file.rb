require 'package'

class Perl_io_file < Package
  description 'Supply object methods for filehandles'
  homepage 'https://metacpan.org/pod/IO::File'
  version '1.51-perl5.38.2'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/T/TO/TODDR/IO-1.51.tar.gz'
  source_sha256 '5493ea55998728cd2b7ecb8234c58fb5d5df27098d0f07addca22444d7616ce0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b79d39077e19f447cc7c0996ed050f1307c5634cceb6f99ecccccb575298715d',
     armv7l: 'b79d39077e19f447cc7c0996ed050f1307c5634cceb6f99ecccccb575298715d',
       i686: 'b510368393e30af7855e0e4e34ff4b973bacb308d72e6a18d38a331ed3e0020a',
     x86_64: 'bafe351f413e47c1e877938c5679d07f46c68610868c4fb18a36337e1587d345'
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
