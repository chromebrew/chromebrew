require 'package'

class Py3_certifi < Package
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/' # 403 Forbidden on 2021.05.08, still 403 Forbidden on 2021.10.13
  @_ver = '2023.05.07'
  version "#{@_ver}-py3.11"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_certifi/2023.05.07-py3.11_armv7l/py3_certifi-2023.05.07-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_certifi/2023.05.07-py3.11_armv7l/py3_certifi-2023.05.07-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_certifi/2023.05.07-py3.11_i686/py3_certifi-2023.05.07-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_certifi/2023.05.07-py3.11_x86_64/py3_certifi-2023.05.07-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '357f8e30de7b9d2da3f7e4b851e36a7958f9b25723c7814a46db8be7f960814c',
     armv7l: '357f8e30de7b9d2da3f7e4b851e36a7958f9b25723c7814a46db8be7f960814c',
       i686: '6883f510a4bfc7622440b0b912f631e766555d2fa6304747e73f2a1a42ca1739',
     x86_64: '8a9eebf9bca1c0d4302a1296ecd1fdf32b4021769dd88952fdee368e83d24558'
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
