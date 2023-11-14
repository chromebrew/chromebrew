Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8
require 'json'
require 'package'

class Pip < Package
  property :pip_install_extras, :pre_configure_options

  def self.install
    puts 'Checking for pip updates'.orange if @opt_verbose
    system "python3 -s -m pip install -U pip | grep -v 'Requirement already satisfied'", exception: false
    @py_pkg = name.gsub('py3_', '')
    puts "Checking for #{@py_pkg} python dependencies...".orange if @opt_verbose
    @py_pkg_pypi = `curl -Ls https://pypi.org/pypi/#{@py_pkg}/json`.chomp
    @py_pkg_pypi_hash = JSON.parse(@py_pkg_pypi)
    @py_pkg_version = @py_pkg_pypi_hash['info']['version']
    @py_pkg_versioned_pypi = `curl -Ls https://pypi.org/pypi/#{@py_pkg}/#{@py_pkg_version}/json`.chomp
    @py_pkg_versioned_pypi_hash = JSON.parse(@py_pkg_versioned_pypi)
    @py_pkg_deps = @py_pkg_versioned_pypi_hash['info']['requires_dist']
    # We don't want extra packages listed in the dependency list, since
    # those are optional.
    @py_pkg_deps.reject! {|x| x.include?('extra ==')} unless @py_pkg_deps.to_s.empty?
    unless @py_pkg_deps.to_s.empty?
      puts "Installing #{@py_pkg} python dependencies with pip...".orange
      @py_pkg_deps.each do |pip_dep|
        @cleaned_py_dep = pip_dep[/[^;]+/]
        puts "——Installing: #{@cleaned_py_dep}".gray
        system "python3 -s -m pip install -U #{@cleaned_py_dep} | grep -v 'Requirement already satisfied'", exception: false
      end
    end
    puts "Installing #{@py_pkg} python module. This may take a while...".lightblue
    puts "Additional pre_configure_options being used: #{@pre_configure_options.nil? || @pre_configure_options.empty? ? '<no pre_configure_options>' : @pre_configure_options}".orange
    system "MAKEFLAGS=-j#{CREW_NPROC} #{@pre_configure_options} python -s -m pip install -U #{@py_pkg} | grep -v 'Requirement already satisfied'", exception: false
    @pip_files = `python3 -s -m pip show -f #{@py_pkg}`.chomp
    @pip_files_base = @pip_files[/(?<=Location: ).*/, 0].concat('/')
    @pip_files_lines = @pip_files[/(?<=Files:\n)[\W|\w]*/, 0].split
    @pip_files_lines.each do |pip_file|
      @pip_path = File.expand_path("#{@pip_files_base}#{pip_file}")
      @destpath = "#{CREW_DEST_DIR.chomp('/')}#{@pip_path}"
      FileUtils.install @pip_path, @destpath
    end
    eval @pip_install_extras if @pip_install_extras
  end
end
