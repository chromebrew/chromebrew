require_relative '../package'
require_relative '../require_gem'
require_relative '../report_buildsystem_methods'

class Meson < Package
  property :meson_build_relative_dir, :meson_options, :meson_build_extras, :meson_install_extras, :meson_pre_cache_build_extras, :pre_meson_options

  def self.prebuild_config_and_report
    @meson_build_relative_dir ||= '.'
    @crew_meson_options = @no_mold ? CREW_MESON_OPTIONS.gsub('-fuse-ld=mold', '') : CREW_MESON_OPTIONS
    @crew_meson_options.gsub!('-Db_lto=true', '-Db_lto=false').gsub!('-flto=auto', '') if @no_lto

    extend ReportBuildsystemMethods

    print_buildsystem_methods
  end

  def self.pre_cached_build
    Dir.chdir @meson_build_relative_dir do
      @meson_pre_cache_build_extras&.call
    end
  end

  def self.build
    system "#{@pre_meson_options} meson setup #{@crew_meson_options} #{@meson_options} #{@meson_build_relative_dir}/builddir #{@meson_build_relative_dir}" unless File.file?("#{@meson_build_relative_dir}/build.ninja")
    system "meson configure --no-pager #{@meson_build_relative_dir}/builddir"
    system "#{CREW_PREFIX}/bin/jobserver_pool.py -j #{CREW_NPROC} #{CREW_NINJA} -C #{@meson_build_relative_dir}/builddir"
    @meson_build_extras&.call
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C #{@meson_build_relative_dir}/builddir install"
    @meson_install_extras&.call
  end

  def self.check
    puts "Testing with #{CREW_NINJA} test.".orange if @run_tests
    system "#{CREW_NINJA} -C #{@meson_build_relative_dir}/builddir test" if @run_tests
  end
end
