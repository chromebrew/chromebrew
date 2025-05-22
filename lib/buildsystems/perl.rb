require 'package'
require 'require_gem'

class PERL < Package
  property :pre_perl_options, :perl_build_extras, :perl_install_extras

  def self.prebuild
    method_list = methods.grep(/#{superclass.to_s.downcase}_/).delete_if { |i| send(i).blank? }
    return if method_list.empty?

    require_gem 'method_source'
    method_blocks = []
    method_strings = []
    method_list.sort.each do |method|
      @method_info = send method
      if @method_info.is_a? String
        method_strings << "#{method}: #{@method_info}".orange
      else
        method_blocks << @method_info.source.to_s.orange
      end
    end
    puts "Additional #{superclass.to_s.capitalize} options being used:".orange
    puts method_strings
    puts method_blocks

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
