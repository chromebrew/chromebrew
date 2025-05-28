require_relative '../package'
require_relative '../require_gem'
require_relative '../report_buildsystem_methods'

class PERL < Package
  property :pre_perl_options, :perl_build_extras, :perl_install_extras

  def self.prebuild
    extend ReportBuildsystemMethods
    print_buildsystem_methods

    system "#{@pre_perl_options} perl Makefile.PL"
    system "sed -i 's,/usr/local,#{CREW_PREFIX},g' Makefile"
  end

  def self.build
    system "#{@pre_perl_options} make"
    @perl_build_extras&.call
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    @perl_install_extras&.call
  end
end
