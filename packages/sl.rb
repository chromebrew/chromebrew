require 'package'

class Sl < Package
  description 'Steam Locomotive runs across your terminal when you type "sl" as you meant to type "ls".'
  homepage 'https://github.com/mtoyoda/sl/'
  version '5.02'
  license 'Toyoda'
  compatibility 'all'
  source_url 'https://github.com/mtoyoda/sl/archive/5.02.tar.gz'
  source_sha256 '1e5996757f879c81f202a18ad8e982195cf51c41727d3fea4af01fdcbbb5563a'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '6eec64e45434268292b6c3529799b67ddca817418807fe3ce724a3c0f6a5be84',
     armv7l: '6eec64e45434268292b6c3529799b67ddca817418807fe3ce724a3c0f6a5be84',
       i686: '1e8ce70c5f1b292c3187e708bd2603de328af24e64b0f6e3c38fec41b1db0083',
     x86_64: 'e357445a2f8c73f9e9de3fd0b5e5383d809991b0633b82bd1ce28e0ced33c315'
  })

  def self.patch
    @addeoption = <<~EOF
      --- a/sl.c
      +++ b/sl.c
      @@ -53,6 +53,7 @@
       int LOGO      = 0;
       int FLY       = 0;
       int C51       = 0;
      +int INTR      = 0;

       int my_mvaddstr(int y, int x, char *str)
       {
      @@ -73,6 +74,7 @@
                   case 'F': FLY      = 1; break;
                   case 'l': LOGO     = 1; break;
                   case 'c': C51      = 1; break;
      +            case 'e': INTR     = 1; break;
                   default:                break;
               }
           }
      @@ -88,7 +90,9 @@
               }
           }
           initscr();
      -    signal(SIGINT, SIG_IGN);
      +    if (INTR == 1) {
      +        signal(SIGINT, SIG_IGN);
      +    }
           noecho();
           curs_set(0);
           nodelay(stdscr, TRUE);
    EOF
    File.write('add_-e_option.patch', @addeoption)
    system 'patch -Np1 -i add_-e_option.patch'

    system "sed -i 's:#include <curses.h>:#include <ncursesw/curses.h>:' sl.c"
  end

  def self.build
    system 'gcc -o sl sl.c -O2 -pipe -flto=auto -fuse-ld=gold -lncursesw -ltinfow'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include/"
    FileUtils.install 'sl', "#{CREW_DEST_PREFIX}/bin/sl", mode: 0o755
    FileUtils.install 'sl.1', "#{CREW_DEST_MAN_PREFIX}/man1/sl.1", mode: 0o644
    FileUtils.install 'sl.h', "#{CREW_DEST_PREFIX}/include/sl.h", mode: 0o644
  end
end
