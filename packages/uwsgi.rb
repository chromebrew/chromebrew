require 'package'

class Uwsgi < Package
  description 'uWSGI application server container'
  homepage 'https://uwsgi-docs.readthedocs.io/en/latest/'
  version '2.0.17'
  compatibility 'all'
  source_url 'https://github.com/unbit/uwsgi/archive/2.0.17.tar.gz'
  source_sha256 '3dc2e9b48db92b67bfec1badec0d3fdcc0771316486c5efa3217569da3528bf2'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'pcre'

  def self.build
    puts
    system "echo 'Select plugin(s):' && ls plugins"
    puts
    system "echo -n 'Enter selection (separate multiple plugins by a space) [python]: '"
    plugins = STDIN.gets.chomp
    puts
    system "make #{plugins}"
  end

  def self.install
    system "install -Dm755 uwsgi #{CREW_DEST_PREFIX}/bin/uwsgi"
  end
end
