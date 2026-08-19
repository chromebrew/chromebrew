require 'package'

class Uwsgi < Package
  description 'uWSGI application server container'
  homepage 'https://uwsgi-docs.readthedocs.io/'
  version '2.0.31'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/unbit/uwsgi.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a8b6047057a3ffff0726325ae3cf0ebe830655ef92c78a4f8b282668b8e28f65',
     armv7l: 'a8b6047057a3ffff0726325ae3cf0ebe830655ef92c78a4f8b282668b8e28f65',
       i686: 'bb7c677a15901b9252021548938ec7f7eadf654128fcc1c13256afdff2babda6',
     x86_64: 'be2d84db95ed5ff9ad4a7c74bcd05dc6909b7a24c60429e729245c64aca67776'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libcap' => :executable
  depends_on 'libxcrypt' => :executable
  depends_on 'libxml2' => :executable
  depends_on 'openssl' => :executable
  depends_on 'pcre' => :executable
  depends_on 'pcre2' => :executable
  depends_on 'python3' => :executable
  depends_on 'util_linux' => :executable
  depends_on 'zlib' => :executable

  def self.build
    puts
    system "echo 'Select plugin(s):' && ls plugins"
    puts
    system "echo -n 'Enter selection (separate multiple plugins by a space) [python]: '"
    plugins = $stdin.gets.chomp.downcase
    puts
    system "make #{plugins}"
  end

  def self.install
    FileUtils.install 'uwsgi', "#{CREW_DEST_PREFIX}/bin/uwsgi", mode: 0o755
  end
end
