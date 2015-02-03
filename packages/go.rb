require 'package'

class Go < Package
  version '1.4.1'
  source_url 'https://storage.googleapis.com/golang/go1.4.1.src.tar.gz'
  source_sha1 'c7a683e8d39b835e333199d68d0c0baefcd24a68'

  def self.build
    FileUtils.cd('src') do
      system "./all.bash"
    end
  end

  def self.install
    system "cp ../go -r /usr/local/lib/"
    if File.file?('/usr/local/bin/go')
      system "sudo rm /usr/local/bin/go"
    end
    if File.file?('/usr/local/bin/gofmt')
      system "sudo rm /usr/local/bin/gofmt"
    end
    if File.file?('/usr/local/bin/godoc')
      system "sudo rm /usr/local/bin/godoc"
    end
    
    system "sudo cp -r /usr/local/tmp/go /usr/local/lib/"
    system "sudo ln -s /usr/local/lib/go/bin/go /usr/local/bin/go"
    system "sudo ln -s /usr/local/lib/go/bin/godoc /usr/local/bin/godoc"
    system "sudo ln -s /usr/local/lib/go/bin/gofmt /usr/local/bin/gofmt"
    
    puts "---\nCorrected\n---"
    puts "Installed Go for linux/amd64 in /usr/local/lib/go"
    puts "Installed commands in /usr/local/bin"
  end
end
