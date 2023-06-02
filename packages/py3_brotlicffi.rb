require 'package'

class Py3_brotlicffi < Package
  description 'Python bindings to the Brotli compression library'
  homepage 'https://github.com/python-hyper/brotlicffi/'
  @_ver = '1.0.9.2'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_brotlicffi/1.0.9.2-py3.11_armv7l/py3_brotlicffi-1.0.9.2-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_brotlicffi/1.0.9.2-py3.11_armv7l/py3_brotlicffi-1.0.9.2-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_brotlicffi/1.0.9.2-py3.11_i686/py3_brotlicffi-1.0.9.2-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_brotlicffi/1.0.9.2-py3.11_x86_64/py3_brotlicffi-1.0.9.2-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '76b7a7b83208bea947459636d4e6a7ee89a331476c5228d0437ebf02d1b9a94e',
     armv7l: '76b7a7b83208bea947459636d4e6a7ee89a331476c5228d0437ebf02d1b9a94e',
       i686: '27db1547e57105b161198fb39bdfb9f89a30031fa2ca7ebe8b9a9861216cb85b',
     x86_64: 'be9ff7820b7cd324d12a46ea2ca0cd3bc6a3fa97062e1610dadba67f9e5703e9'
  })

  depends_on 'brotli'
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'py3_cffi'
  depends_on 'py3_pip' # L
  depends_on 'python3' # L

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
