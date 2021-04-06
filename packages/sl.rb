require 'package'

class Sl < Package
  description 'Steam Locomotive runs across your terminal when you type "sl" as you meant to type "ls".'
  homepage 'https://github.com/mtoyoda/sl'
  version '5.02'
  license 'Toyoda'
  compatibility 'all'
  source_url 'https://github.com/mtoyoda/sl/archive/5.02.tar.gz'
  source_sha256 '1e5996757f879c81f202a18ad8e982195cf51c41727d3fea4af01fdcbbb5563a'

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
      +    if (INTR == 0) {
      +        signal(SIGINT, SIG_IGN);
      +    }
           noecho();
           curs_set(0);
           nodelay(stdscr, TRUE);
    EOF
    IO.write("add_-e_option.patch", @addeoption)
    system "patch -Np1 -i add_-e_option.patch"
  end

  def self.build
    system "sed -i 's:#include <curses.h>:#include <ncursesw/curses.h>:' sl.c"
    system "gcc -O2 -pipe -o sl sl.c -ltinfow"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1/"
    FileUtils.install 'sl', "#{CREW_DEST_PREFIX}/bin/sl", mode: 0755
    FileUtils.install 'sl.1', "#{CREW_DEST_MAN_PREFIX}/man1/sl.1", mode: 0644
    FileUtils.install 'sl.h', "#{CREW_DEST_PREFIX}/include/sl.h", mode: 0644

    FileUtils.mkdir "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # sl configuration
      # sl does this annoying thing where it doesn't allow the user to cancel with ^include Comparable
      # To disable this "feature", uncomment the line below
      #alias sl="sl -e"
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/sl", @env)
  end
end
