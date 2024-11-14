require 'package'
Package.load_package("#{__dir__}/libxml2.rb")

class Py3_libxml2 < Package
  description 'Libxml2-python provides access to libxml2 and libxslt in Python.'
  homepage 'https://gitlab.gnome.org/GNOME/libxml2/'
  version "#{Libxml2.version}-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url Libxml2.source_url
  git_hashtag Libxml2.git_hashtag
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6104bab109fab73576daa07ae3bc5c2c174615b17f85b65d52696bfcb84f33b8',
     armv7l: '6104bab109fab73576daa07ae3bc5c2c174615b17f85b65d52696bfcb84f33b8',
       i686: '7ff32e8616aba0682996bb630d35bd551a2a10f302c5b0cb659a1f901cb1c65e',
     x86_64: '8d6a0a678776b2988cb6826f0f778f204cf552e0d40909436f804a6ebf90ce52'
  })

  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' # R
  depends_on 'zlib' # R

  no_fhs

  def self.build
    system 'autoreconf -fiv'
    system "./configure #{CREW_CONFIGURE_OPTIONS}"
    Dir.chdir('python') do
      @pip_wheel = `python setup.py bdist_wheel`[/(?<=filename=)(.*)*?(\S+)/, 0]
    end
  end

  def self.install
    @pip_cache_dest_dir = File.join(CREW_DEST_DIR, `pip cache dir`.chomp)
    FileUtils.mkdir_p @pip_cache_dest_dir
    @py_pkg = 'libxml2-python'
    Dir.chdir('python') do
      system "python3 -m pip install --force-reinstall -U dist/#{@pip_wheel}"
      FileUtils.install "dist/#{@pip_wheel}", @pip_cache_dest_dir
    end
    @pip_show = `python3 -s -m pip --no-color show -f #{@py_pkg}`.chomp
    # Error out if the pip install has no files.
    unless @pip_show.include?('Files:')
      puts @pip_show
      abort "pip install of #{@py_pkg} failed.".lightred
    end
    @pip_pkg_version = @pip_show[/(?<=Version: ).*/, 0]
    @pip_show_location = @pip_show[/(?<=Location: ).*/, 0].concat('/')
    @pip_show_files = @pip_show[/(?<=Files:\n)[\W|\w]*/, 0].split
    @pip_show_files.each do |pip_file|
      @pip_file_path = File.expand_path("#{@pip_show_location}#{pip_file}")
      @pip_file_destpath = File.join(CREW_DEST_DIR, @pip_file_path)
      # Handle older FileUtils from older ruby versions.
      FileUtils.mkdir_p File.dirname(@pip_file_destpath) if Gem::Version.new(RUBY_VERSION.to_s) < Gem::Version.new('3.3')
      begin
        FileUtils.install @pip_file_path, @pip_file_destpath
      rescue Errno::ENOENT
        puts @pip_show_files
        abort "Problem installing #{@pip_file_path} from #{@py_pkg}==#{@pip_pkg_version} to #{@pip_file_destpath}".lightred
      end
    end
  end
end
