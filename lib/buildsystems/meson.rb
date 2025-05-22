require 'package'
require 'require_gem'

class Meson < Package
  property :meson_options, :pre_meson_options, :meson_build_extras, :meson_install_extras

  def self.build
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

    system "#{@pre_meson_options} meson setup #{@crew_meson_options} #{@meson_options} builddir"
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
    @meson_build_extras&.call
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    @meson_install_extras&.call
  end

  def self.check
    puts "Testing with #{CREW_NINJA} test.".orange if @run_tests
    system "#{CREW_NINJA} -C builddir test" if @run_tests
  end
end
