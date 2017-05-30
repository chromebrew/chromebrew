require 'package'

class Pip < Package # the name of the package
  version '1.0' # the current version of the package
  source_url 'https://dl.dropboxusercontent.com/u/14799278/crew/get-pip.tar.gz' # the source files for the package
  source_sha1 'b6d86af835532c0225b4297be9502e15b43ba638'

  depends_on 'python27'

  def self.build
    system "sudo python get-pip.py"
  end

  def self.install
    system "echo PIP Installed!"
  end
end
