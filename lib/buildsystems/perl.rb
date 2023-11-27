require 'package'

class PErl < Package
  property :pre_perl_options

  def self.prebuild
    puts "Additional pre_perl_options being used: #{@pre_perl_options.nil? ? '<no pre_perl_options>' : @pre_perl_options}".orange
    system "#{@pre_perl_options} perl Makefile.PL"
    system "sed -i 's,/usr/local,#{CREW_PREFIX},g' Makefile"
  end

  def self.build
    @mold_linker_prefix_cmd = CREW_LINKER == 'mold' ? 'mold -run' : ''
    system "#{@pre_perl_options} #{@mold_linker_prefix_cmd} make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
