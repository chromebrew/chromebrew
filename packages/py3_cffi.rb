require 'package'

class Py3_cffi < Package
  description 'C Foreign Function Interface for Python calling C code.'
  homepage 'https://cffi.readthedocs.io/'
  @_ver = '1.15.1'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/2b/a8/050ab4f0c3d4c1b8aaa805f70e26e84d0e27004907c5b8ecc1d31815f92a/cffi-1.15.1.tar.gz'
  source_sha256 'd400bfb9a37b1351253cb402671cea7e89bdecc294e8016a707f6d1d8ac934f9'

  depends_on 'glibc' # R
  depends_on 'libffi' # R
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
