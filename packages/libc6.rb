require 'package'

class Libc6 < Package
  description 'Debian libc6 Library version 2.24'
  homepage 'https://packages.debian.org/stretch/libc6'
  version '2.24'
  source_url 'https://github.com/skycocker/chromebrew/files/2059646/bashrc.txt'
  source_sha256 '17346974f26e49b1261fb35ef51261fbcc9043844f63eb736ec3c2f2e0453ec2'

  depends_on 'dpkg' => :build
  
  def self.install
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}"
    case ARCH
    when 'aarch64'
      system "wget", "-q", "http://ftp.debian.org/debian/pool/main/g/glibc/libc6-dev_2.24-11+deb9u3_arm64.deb"
      system "dpkg-run", "-x", "libc6-dev_2.24-11+deb9u3_arm64.deb", "#{CREW_DEST_PREFIX}"
    when 'armv7l'
      system "wget", "-q", "http://ftp.debian.org/debian/pool/main/g/glibc/libc6-dev_2.24-11+deb9u3_armhf.deb"
      system "dpkg-run", "-x", "libc6-dev_2.24-11+deb9u3_armhf.deb", "#{CREW_DEST_PREFIX}"
    when 'i686'
      system "wget", "-q", "http://ftp.debian.org/debian/pool/main/g/glibc/libc6-dev_2.24-11+deb9u3_i386.deb"
      system "dpkg-run", "-x", "libc6-dev_2.24-11+deb9u3_i386.deb", "#{CREW_DEST_PREFIX}"
    when 'x86_64'
      system "wget", "-q", "http://ftp.debian.org/debian/pool/main/g/glibc/libc6-dev_2.24-11+deb9u3_amd64.deb"
      system "dpkg-run", "-x", "libc6-dev_2.24-11+deb9u3_amd64.deb", "#{CREW_DEST_PREFIX}"
    end
    system "cp", "-r", "#{CREW_DEST_PREFIX}/usr/include", "#{CREW_DEST_PREFIX}"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include/misc/"
    case ARCH
    when 'i686'
      system "cp", "-r", "#{CREW_DEST_PREFIX}/include/i386-linux-gnu/sys", "#{CREW_DEST_PREFIX}/include/misc/"
      system "cp", "-r", "#{CREW_DEST_PREFIX}/include/i386-linux-gnu/bits", "#{CREW_DEST_PREFIX}/include/"
    when 'armv7l'
      system "cp", "-r", "#{CREW_DEST_PREFIX}/include/arm-linux-gnueabihf/sys", "#{CREW_DEST_PREFIX}/include/misc/"
      system "cp", "-r", "#{CREW_DEST_PREFIX}/include/arm-linux-gnueabihf/bits", "#{CREW_DEST_PREFIX}/include/"
    else
      system "cp", "-r", "#{CREW_DEST_PREFIX}/include/#{ARCH}-linux-gnu/sys", "#{CREW_DEST_PREFIX}/include/misc/"
      system "cp", "-r", "#{CREW_DEST_PREFIX}/include/#{ARCH}-linux-gnu/bits", "#{CREW_DEST_PREFIX}/include/"
    end
      case ARCH
      when 'aarch64', 'x86_64'
        system "mv", "#{CREW_DEST_PREFIX}/usr/lib", "#{CREW_DEST_PREFIX}/lib64"
      else
        system "cp", "-r", "#{CREW_DEST_PREFIX}/usr/lib", "#{CREW_DEST_PREFIX}"
      end
    system "cp", "-r", "#{CREW_DEST_PREFIX}/usr/share", "#{CREW_DEST_PREFIX}"
    system "cp", "-r", "#{CREW_DEST_PREFIX}/include/misc/sys/", "#{CREW_DEST_PREFIX}/include/"
    system "rm", "-r", "#{CREW_DEST_PREFIX}/usr/"
  end

  def self.postinstall
    puts "Please execute".lightblue
    case ARCH
    when 'i686'
      puts "echo 'export LD_LIBRARY_PATH=\"$LD_LIBRARY_PATH:#{CREW_PREFIX}/lib/i386-linux-gnu\"' >> ~/.bashrc && source ~/.bashrc".lightblue
    when 'armv7l'
      puts "echo 'export LD_LIBRARY_PATH=\"$LD_LIBRARY_PATH:#{CREW_PREFIX}/lib/arm-linux-gnueabihf\"' >> ~/.bashrc && source ~/.bashrc".lightblue
    else
      puts "echo 'export LD_LIBRARY_PATH=\"$LD_LIBRARY_PATH:#{CREW_PREFIX}/lib64/#{ARCH}-linux-gnu\"' >> ~/.bashrc && source ~/.bashrc".lightblue
    end
    puts "To add libc6 to your $LD_LIBRARY_PATH".lightblue
  end
end
