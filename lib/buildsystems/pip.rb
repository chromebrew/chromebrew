require 'package'

class Pip < Package
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
end
