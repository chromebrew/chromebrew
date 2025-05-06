require 'package'

class PERL < Package
  property :pre_perl_options, :perl_build_extras, :perl_install_extras

  def self.prebuild
    puts "Additional pre_perl_options being used: #{@pre_perl_options.nil? ? '<no pre_perl_options>' : @pre_perl_options}".orange
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
