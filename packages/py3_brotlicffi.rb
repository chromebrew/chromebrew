require 'package'

class Py3_brotlicffi < Package
  description 'Python bindings to the Brotli compression library'
  homepage 'https://github.com/python-hyper/brotlicffi/'
  @_ver = '1.0.9.2'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/python-hyper/brotlicffi.git'
  git_hashtag "v#{@_ver}"

  depends_on 'brotli'
  depends_on 'py3_cffi'
  depends_on 'python3' # L
  depends_on 'py3_pip' # L
  no_compile_needed

  def self.postinstall
    puts "Installing #{name.gsub('Py3_', '')} python module. This may take a while...".lightblue
    system "pip install #{name.gsub('Py3_', '')}", exception: false
    @pip_files = `pip show -f #{name.gsub('Py3_', '')}`.chomp
    @pip_files_base = @pip_files[/(?<=Location: ).*/, 0].concat('/')
    @pip_files_lines = @pip_files[/(?<=Files:\n)[\W|\w]*/, 0].split
    File.open("#{CREW_META_PATH}#{name.downcase}.filelist", 'w+') do |f|
      @pip_files_lines.each do |pip_file|
        f.puts File.expand_path("#{@pip_files_base}#{pip_file}")
      end
    end
  end

  def self.remove
    system "pip uninstall #{name.gsub('Py3_', '')} -y", exception: false
  end
end
