require 'package'

class Perl_gcstring_linebreak < Package
  description 'UAX 14 Unicode Line Breaking Algorithm - Perl binding Unicode::LineBreak Unicode::GCString'
  homepage 'http://search.cpan.org/~nezumi/Unicode-LineBreak-2018.003/lib/Unicode/LineBreak.pod'
  version '2018.003'
  source_url 'https://github.com/hatukanezumi/Unicode-LineBreak/archive/Unicode-LineBreak-2018.003.tar.gz'
  source_sha256 '6f8cb4de140f8b63924786df8b0c2389c342bccdee05fbb1b9af8d8b6a8a3fad'

  def self.build
      system "git", "clone", "--recurse-submodules", "https://github.com/hatukanezumi/Unicode-LineBreak", "-b", "Unicode-LineBreak-2018.003"
    Dir.chdir ("Unicode-LineBreak") do
      system "perl", "Makefile.PL"
      system "make"
    end
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
