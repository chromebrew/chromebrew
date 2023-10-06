require 'package'

class Py3_pip < Package
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  @_ver = '23.2.1'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag @_ver

  depends_on 'python3', '< 3.13.0'
  conflicts_ok
  no_compile_needed

  def self.build
    # Pip is installed inside Python 3. The following steps ensure that
    # pip can properly build other packages from buildsystems/pip.
    @required_pip_modules = %w[build installer setuptools wheel pyproject_hooks]
    @pip_list = `pip list --exclude pip`
    @required_pip_modules.each do |pip_pkg|
      unless @pip_list.include?(pip_pkg)
        puts "Installing #{pip_pkg} using pip..."
        system "MAKEFLAGS=-j#{CREW_NPROC} pip install #{pip_pkg}"
      end
    end
  end

  def self.install
    puts "Installing #{name.gsub('py3_', '')} python module. This may take a while...".lightblue
    system "MAKEFLAGS=-j#{CREW_NPROC} python -s -m pip install #{name.gsub('py3_', '')}", exception: false
    @pip_files = `python3 -s -m pip show -f #{name.gsub('py3_', '')}`.chomp
    @pip_files_base = @pip_files[/(?<=Location: ).*/, 0].concat('/')
    @pip_files_lines = @pip_files[/(?<=Files:\n)[\W|\w]*/, 0].split
    @pip_files_lines.each do |pip_file|
      @pip_path = File.expand_path("#{@pip_files_base}#{pip_file}")
      @destpath = "#{CREW_DEST_DIR.chomp('/')}#{@pip_path}"
      FileUtils.install @pip_path, @destpath
    end
  end

  def self.postinstall
    puts 'Updating pip packages...'.lightblue
    system 'pip --disable-pip-version-check list --outdated --format=json | python -c "import json, sys; print(\'\n\'.join([x[\'name\'] for x in json.load(sys.stdin)]))" | xargs -rn1 pip install -U', exception: false
  end
end
