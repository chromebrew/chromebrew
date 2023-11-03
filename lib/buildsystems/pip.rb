Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8
require 'json'
require 'package'

class Pip < Package
  property :pip_install_extras

  def self.install
    puts 'Checking for pip updates'.orange if @opt_verbose
    system 'python3 -s -m pip install -U pip', exception: false
    @py_pkg = name.gsub('py3_', '')
    puts "Checking for #{@py_pkg} python dependencies...".orange if @opt_verbose
    @py_pkg_pypi = `curl -Ls https://pypi.org/pypi/#{@py_pkg}/json`.chomp
    @py_pkg_pypi_hash = JSON.parse(@py_pkg_pypi)
    @py_pkg_version = @py_pkg_pypi_hash['info']['version']
    @py_pkg_versioned_pypi = `curl -Ls https://pypi.org/pypi/#{@py_pkg}/#{@py_pkg_version}/json`.chomp
    @py_pkg_versioned_pypi_hash = JSON.parse(@py_pkg_versioned_pypi)
    @py_pkg_deps = @py_pkg_versioned_pypi_hash['info']['requires_dist']
    unless @py_pkg_deps.to_s.empty?
      puts "Installing #{@py_pkg} python dependencies with pip...".orange
      @py_pkg_deps.each do |pip_dep|
        @cleaned_py_dep = pip_dep[/[^;]+/]
        puts "Installing #{@cleaned_py_dep} using 'pip install #{@cleaned_py_dep}'".orange if @opt_verbose
        system "pip install #{@cleaned_py_dep}", exception: false
      end
    end
    puts "Installing #{@py_pkg} python module. This may take a while...".lightblue
    system "MAKEFLAGS=-j#{CREW_NPROC} python -s -m pip install #{@py_pkg}", exception: false
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
