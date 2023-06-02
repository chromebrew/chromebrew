require 'package'

class Py3_pycryptodomex < Package
  description 'Pycryptodomex is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  @_ver = '3.18.0'
  version "#{@_ver}-py3.11"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodomex/3.18.0-py3.11_armv7l/py3_pycryptodomex-3.18.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodomex/3.18.0-py3.11_armv7l/py3_pycryptodomex-3.18.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodomex/3.18.0-py3.11_i686/py3_pycryptodomex-3.18.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodomex/3.18.0-py3.11_x86_64/py3_pycryptodomex-3.18.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '844df670ebf620b06c5b608fa48678090052c3939045bc09a386f30e127509eb',
     armv7l: '844df670ebf620b06c5b608fa48678090052c3939045bc09a386f30e127509eb',
       i686: '250a64cc6b7479bd29b7c978a760694b3a2960e624baeb7e97a7df59622f54eb',
     x86_64: 'd820a82e49e252c499dc43b72fd20459109c4d6ad30f3231116ef7ad81fc4d37'
  })

  depends_on 'glibc' # R
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
