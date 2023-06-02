require 'package'

class Py3_mutagen < Package
  description 'Python module for handling audio metadata'
  homepage 'https://mutagen.readthedocs.io/'
  @_ver = '1.46.0'
  version "#{@_ver}-py3.11"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mutagen/1.46.0-py3.11_armv7l/py3_mutagen-1.46.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mutagen/1.46.0-py3.11_armv7l/py3_mutagen-1.46.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mutagen/1.46.0-py3.11_i686/py3_mutagen-1.46.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mutagen/1.46.0-py3.11_x86_64/py3_mutagen-1.46.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fea341c321ffb9d0776016ad2f992fe0dc00f5d2c14dadbe6980f319205d9f66',
     armv7l: 'fea341c321ffb9d0776016ad2f992fe0dc00f5d2c14dadbe6980f319205d9f66',
       i686: 'b1998398f37e75e4076328401e1829fcfe80518348b97108a5684e938d33e0a5',
     x86_64: '40cbb9bbf771a974b9aafad3fed3396a06cdfa455c68289b7c8e10c4f1838f52'
  })

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
      @destpath = "#{CREW_DEST_DIR.chomp('/')}#{@pip_path}"
      FileUtils.install @pip_path, @destpath
    end
  end
end
