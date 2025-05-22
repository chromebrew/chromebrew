require 'convenience_functions'
require 'package'

class Meson < Package
  property :meson_options, :pre_meson_options, :meson_build_extras, :meson_install_extras

  def self.build
    ConvenienceFunctions.print_buildsystems_methods

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
