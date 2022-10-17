require 'package'

class Perl_cpan_v1 < Package
  @_buildsystems_perl_cpan_version = '1.0.0'

  def self.check?(bool = true)
    return (@check = bool)
  end

  depends_on 'perl'

  def self.prebuild
    system 'perl', 'Makefile.PL'
    system "sed -i 's,/usr/local,#{CREW_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  if @check
    def self.check
      system 'make', 'test'
    end
  end
end
