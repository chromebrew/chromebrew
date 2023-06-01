require 'package'

class Py3_websockets < Package
  description ' Library for building WebSocket servers and clients in Python'
  homepage 'https://websockets.readthedocs.io/'
  @_ver = '11.0.3'
  version "#{@_ver}-py3.11"
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/aaugustin/websockets.git'
  git_hashtag @_ver

  depends_on 'python3' # L
  depends_on 'py3_pip' # L

  def self.install
    puts "Installing #{name.gsub('py3_', '')} python module. This may take a while...".lightblue
    system "python -s -m pip install #{name.gsub('py3_', '')}", exception: false
    @pip_files = `python -s -m pip show -f #{name.gsub('py3_', '')}`.chomp
    @pip_files_base = @pip_files[/(?<=Location: ).*/, 0].concat('/')
    @pip_files_lines = @pip_files[/(?<=Files:\n)[\W|\w]*/, 0].split
    @pip_files_lines.each do |pip_file|
      @pip_path = File.expand_path("#{@pip_files_base}#{pip_file}")
      @destpath = "#{CREW_DEST_DIR.chomp("/")}#{@pip_path}"
      FileUtils.install @pip_path, @destpath
    end
  end
end
