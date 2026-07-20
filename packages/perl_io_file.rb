require 'buildsystems/perl'

class Perl_io_file < PERL
  description 'Supply object methods for filehandles'
  homepage 'https://metacpan.org/pod/IO::File'
  version "1.55_01-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/T/TO/TODDR/IO-1.55_01.tar.gz'
  source_sha256 '6f51f8dc75c9fa42b1dcd8194575f21f7e0353136a4c9b36e27da1fbeb698074'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '20e61e6b245098d2ef68349800bd5deadf14923801855f742c9e30cdba2195c3',
     armv7l: '20e61e6b245098d2ef68349800bd5deadf14923801855f742c9e30cdba2195c3',
       i686: '8c6c0aee29007512f811a67d89c299bb502a91a50b1c1b5222f39630a945270c',
     x86_64: 'c0cc0d572bc3704a51ced478b7b26f7ddf9cbde2f345ccf3fbaed28bba45879c'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'perl' => :logical
  depends_on 'perl_file_temp' => :build

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
