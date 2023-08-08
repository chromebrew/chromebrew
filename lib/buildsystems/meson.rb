require 'package'

class Meson < Package
  property :meson_options

  def self.build
    puts "Additional meson_options being used: #{@meson_options.nil? || @meson_options.empty? ? '<no meson_options>' : @meson_options}".orange
    @crew_meson_options = @no_lto ? CREW_MESON_FNO_LTO_OPTIONS : CREW_MESON_OPTIONS
    @mold_linker_prefix_cmd = CREW_LINKER == 'mold' ? 'mold -run' : ''
    system "#{@mold_linker_prefix_cmd} meson setup #{@crew_meson_options} #{@meson_options} builddir"
    system 'meson configure builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end

  def self.check
    puts "Testing with #{CREW_NINJA} test.".orange if @run_tests
    system "#{CREW_NINJA} -C builddir test" if @run_tests
  end
end
